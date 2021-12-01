whitespace = " \t\n\r"
symbols = "()"

# Shortcut function for print without newline
write = lambda x: print(x, end="")

def scan(code):
    i = 0
    code += " "
    while i < len(code):
        char = code[i]
        if char in whitespace:
            pass
        elif char in symbols:
            yield char
        else:
            a = i
            while code[i+1] not in whitespace + symbols:
                i += 1
            yield code[a:i+1]
        i += 1

def parse(code):
    tree = []
    if type(code) is str:
        code = scan(code)
    for token in code:
        if token == "(":
            tree.append(parse(code))
        elif token == ")":
            return tree
        else:
            tree.append(token)
    return tree

# Note: disp and load are in the reference implementation for convenience;
# submissions do not need to treat them as tinylisp builtins

builtins = {"tl_cons": "c",
            "tl_car": "h",
            "tl_cdr": "t",
            "tl_subt2": "s",
            "tl_less2": "l",
            "tl_eq2": "e",
            "tl_eval": "v",
            "tl_disp": "disp",
            # The following four are macros:
            "tl_def": "d",
            "tl_if": "i",
            "tl_quote": "q",
            "tl_load": "load"}

# Decorators for member functions that implement builtins

def macro(pyFn):
    pyFn.isMacro = True
    return pyFn

def function(pyFn):
    pyFn.isMacro = False
    return pyFn

class Program:
    def __init__(self):
        self.names = [{}]
        self.depth = 0
        for name in dir(self):
            # Go through the member functions and put the ones that implement
            # tinylisp functions or macros into the top-level symbol table
            # under their abbreviated names
            if name in builtins:
                tlName = builtins[name]
                self.names[0][tlName] = getattr(self, name)

    def call(self, function, args, fname):
        if type(function) is not list or not 2 <= len(function) <= 3:
            print("Error: object is not callable", function)
            return []
        elif len(function) == 2:
            # Regular function: evaluate all the arguments
            macro = False
            argnames, code = function
            args = [self.tl_eval(arg) for arg in args]
        elif len(function) == 3:
            # Skip first element of macro list, and don't evaluate
            # the arguments
            macro = True
            argnames, code = function[1:]
        self.depth += 1
        self.names.append({})
        while True:
            if type(argnames) is list:
                if len(argnames) == len(args):
                    for name, val in zip(argnames, args):
                        self.names[self.depth][name] = val
                else:
                    print("Error: wrong number of arguments")
                    result = []
                    break
            else:
                # Single name, bind entire arglist to it
                self.names[self.depth][argnames] = args
            # Tail-call elimination
            returnExpr = code
            while type(returnExpr) is list and returnExpr[0] == "i":
                test = self.tl_eval(returnExpr[1])
                if test == 0 or test == []:
                    returnExpr = returnExpr[3]
                else:
                    returnExpr = returnExpr[2]
            if type(returnExpr) is str:
                result = self.tl_eval(returnExpr)
                break
            head = self.tl_eval(returnExpr[0])
            if type(head) is list and 2 <= len(head) <= 3:
                # Swap out the args from the original call for the updated
                # args, the function for the new function (which might be
                # the same function), and loop for the recursive call
                if len(head) == 2:
                    macro = False
                    argnames, code = head
                    args = [self.tl_eval(arg) for arg in returnExpr[1:]]
                elif len(function) == 3:
                    macro = True
                    argnames, code = head[1:]
                    args = returnExpr[1:]
                self.names[self.depth] = {}
                continue
            else:
                result = self.tl_eval(returnExpr)
                break
        del self.names[self.depth]
        self.depth -= 1
        return result

    @function
    def tl_car(self, lyst):
        if len(lyst) == 0:
            return []
        else:
            return lyst[0]

    @function
    def tl_cdr(self, lyst):
        if len(lyst) == 0:
            return []
        else:
            return lyst[1:]

    @function
    def tl_cons(self, head, tail):
        if type(tail) is not list:
            print("Error: cannot cons to non-list in tinylisp")
            return []
        else:
            return [head] + tail

    @macro
    def tl_def(self, name, value):
        if name in self.names[0]:
            print("Error: name already in use")
        else:
            self.names[0][name] = self.tl_eval(value)
        return name

    @function
    def tl_disp(self, value, end="\n"):
        if value == []:
            write("()")
        elif type(value) is list:
            write("(")
            self.tl_disp(value[0], end="")
            for item in value[1:]:
                write(" ")
                self.tl_disp(item, end="")
            write(")")
        elif type(value) is type(self.tl_disp):
            write("<built-in function>")
        else:
            write(value)
        write(end)
        return []

    @function
    def tl_eq2(self, arg1, arg2):
        return +(arg1 == arg2)

    @function
    def tl_eval(self, code, depth=None):
        if depth is None:
            depth = self.depth
        if type(code) is list:
            if code == []:
                return []
            if type(code[0]) is str:
                fname = code[0]
            else:
                fname = None
            function = self.tl_eval(code[0])
            if type(function) is list:
                # User-defined function or macro
                return self.call(function, code[1:], fname)
            elif type(function) is type(self.tl_eval):
                # Builtin function or macro
                if function.isMacro:
                    args = code[1:]
                else:
                    args = (self.tl_eval(param) for param in code[1:])
                return function(*args)
            else:
                # ?!
                print("Error: %s is not a function or macro" % function)
                return []
        elif type(code) is int or code.isdigit():
            # Integer literal
            return int(code)
        else:
            # Atom = name, look up its value
            if code in self.names[depth]:
                return self.names[depth][code]
            elif code in self.names[0]:
                return self.names[0][code]
            else:
                print("Error: referencing undefined name", code)
                return []

    @macro
    def tl_if(self, cond, trueval, falseval):
        # A macro, so arguments are not pre-evaluated
        cond = self.tl_eval(cond)
        if cond == 0 or cond == []:
            return self.tl_eval(falseval)
        else:
            return self.tl_eval(trueval)

    @function
    def tl_less2(self, arg1, arg2):
        return +(arg1 < arg2)

    @function
    def tl_subt2(self, arg1, arg2):
        return arg1 - arg2

    @macro
    def tl_quote(self, quoted):
        return quoted

    @macro
    def tl_load(self, filename):
        if not filename.endswith(".tl"):
            filename += ".tl"
        try:
            with open(filename) as f:
                libraryCode = f.read()
        except IOError:
            print("Error: could not load", filename)
        else:
            run(libraryCode, self)
        return None


def run(code, env=None):
    if type(code) is str:
        code = parse(code)
    if env is None:
        env = Program()
    for expr in code:
        result = env.tl_eval(expr)
        if result is not None:
            env.tl_disp(result)

def repl():
    print("(welcome to tinylisp)")
    environment = Program()
    instruction = input("tl> ")
    while instruction != "(quit)":
        if instruction == "(restart)":
            print("Restarting...")
            environment = Program()
        else:
            run(instruction, environment)
        instruction = input("tl> ")
    print("Bye!")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        # User specified a filename--run it
        filename = sys.argv[1]
        run("(load %s)" % filename)
    else:
        # No filename specified, so...
        repl()
