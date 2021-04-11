import fruitbase, future, sequtils, algorithm

# Collections are very important in Smalltalk, and they offer a huge protocol
# for working with them. The workhorse in Smalltalk is OrderedCollection - which
# together with Dictionary probably covers 90% of all collection use.
# In Nim the equivalent of an OrderedCollection is the type `seq`.
#
# This is a little rundown of what you can do with seq using stdlib.
# For fun we also add some Smalltalk behaviors, to learn how.

# Create an empty collection of Fruit. We can also use:
# var s: seq[Fruit] = @[]
var s = newSeq[Fruit]()

# Some Fruit objects to play with, borrowed from earlier articles on OOP
var b = newBanana(size = 0, origin = "Liberia", price = 20.00222.Dollar)
var p = newPumpkin(weight = 5.2.Kg, origin = "Africa", price = 10.00111.Dollar)

# First we have add(), contains() and len()
s.add(b)
echo("Seq is " & $s.len & " elements long and contains banana: " & $s.contains(b))
echo("Seq is " & $s.len & " elements long and contains pumpkin: " & $s.contains(p))

# We can add with `&` too, but it will copy s into a new seq with at least 1 more slot.
# This needs discard or assignment since it returns a new seq.
# So this is actually concatenation via "copy into a new seq" but for a single element.
s = s & p
echo("Seq is " & $s.len & " elements long and contains pumpkin: " & $s.contains(p))

# We can access using [index] and also let the whole seq represent itself as a string,
# The implementation of `$` of course calls `$` for the contained elements.
echo("First fruit: " & $s[0])
echo("The whole seq: " & $s)

# Simple iteration, uses the items() iterator under the hood. Iterators are normally inlined
# by the compiler and thus cost basically nothing. Calling "items(s)" is not needed,
# the for loop will do that automatically and also infer the type of i for us.
# Smalltalk: s do: [:i | ... ]
for i in s:
  echo(i.origin)

# Insert an element at a given index
s.insert(p, 1)

# Print countries and index, uses pairs() instead of items() to iterate over both index and value.
# Equicalent to Smalltalk: s keysAndValuesDo: [:i :v | ... ]
for i,v in pairs(s):
  echo("index: " & $i & " country: " & v.origin)

# Convert iterator to a seq of key/val tuples, just stumbled over it.
# Like calling Dictionary>>associations in Smalltalk, but here its
# generalized for any kind of iterator.
echo(toSeq(pairs(s)))

# It should produce a copy, so should hold true
assert(toSeq(items(s)) == s)

# Print in string form, neat for debugging.
echo("repr:" & repr(s))

# Delete at index. Here is a little issue with system.nim and sequtils.nim overlapping slightly.
# Should be fixed. The following will not compile since its ambiguous:
#   s.delete(0)
# Instead we need to explicitly call it in the system module.
system.delete(s, 0)

# Get and remove last element.
echo s.pop
echo("The whole seq: " & $s)
echo("Seq is " & $s.len & " elements long and contains banana: " & $s.contains(b))

# Concatenate two seqs copying into a new longer seq. Like in "," in Smalltalk.
s = s & s
echo("After concat seq is " & $s.len)

# Throw in a banana again for tests below
s.add(b)

# Sort using proc syntax
s.sort(proc(x, y: Fruit) :int =
  cmp(x.origin, y.origin))

# Sort using do syntax
s.sort do (x, y: Fruit) -> int:
  cmp(x.origin, y.origin)

# Sort using new lambda syntax
s.sort((x, y: Fruit) =>
  cmp(x.origin, y.origin))


# NOTE: In the following three calls to map we needed to wrap with $(...) to avoid
# an internal error in Compiler for Nim 0.10.1.
#
# Smalltalk's #collect: is Nim's `map`, here using proc syntax.
# In Smalltalk: s collect: [:x | x origin ]
echo($(s.map(proc(x:Fruit): string = x.origin)))
# ...and future lambda syntax, basically as short and clean as Smalltalk!
echo($(s.map((x:Fruit) => x.origin)))
# ...or using mapIt template variant, but needs a type arg for the new seq
echo($(s.mapIt(string, it.origin)))

# Smalltalk's #select: is Nim's `filter`, here using proc syntax.
# In Smalltalk: s select: [:x | x origin = 'Liberia' ]
echo(s.filter(proc(x:Fruit): bool = x.origin == "Liberia"))
# ...and future lambda syntax, almost as short and clean as Smalltalk!
echo(s.filter((x:Fruit) => (x.origin == "Liberia")))
# ...and filterIt template variant, muahaa, shorter than Smalltalk!
echo(s.filterIt(it.origin == "Liberia"))

# But Smalltalk has a HUGE amount of more behaviors like:
#   detect:ifNone:, allSatisfy:, anySatisfy:, reject:, inject:into:
#   ...well, there are TONS we would like :)
#
# Here is allSatisfy: and anySatisfy:, easily implemented.

proc allSatisfy*[T](seq1: seq[T], pred: proc(item: T): bool {.closure.}): bool =
  ## Returns true if all the items fulfill the predicate.
  ##
  ## Example:
  ##
  ## .. code-block::
  ##   let numbers = @[10, 20, 30]
  ##   assert numbers.allSatisfy(proc(x: int): bool = x > 5)
  result = true
  for i in seq1:
    if not pred(i): return false

proc anySatisfy*[T](seq1: seq[T], pred: proc(item: T): bool {.closure.}): bool =
  ## Returns true if any of the items fulfill the predicate.
  ##
  ## Example:
  ##
  ## .. code-block::
  ##   let numbers = @[10, 20, 30]
  ##   assert numbers.anySatisfy(proc(x: int): bool = x > 25)
  result = false
  for i in seq1:
    if pred(i): return true

let numbers = @[10, 20, 30]
assert(numbers.allSatisfy(proc(x: int): bool = x > 5))
assert(numbers.anySatisfy(proc(x: int): bool = x > 25))

echo($s & " all come from Africa: " & $s.allSatisfy((x:Fruit) => (x.origin == "Africa")))

# We can also check if s isNil
echo(s.isNil)
s = nil
echo(s.isNil)

# Let's see what happens if we try to port a few random Smalltalk snippets I wrote
# down just perusing the Smalltalk protocol for OrderedCollection:

# #(1 2 3 4 5) select: [:x | x odd ] thenCollect: [:x | x * 3 ]
# Above we do a filter on an array of Numbers getting those that are odd
# and then we map them by multiplying with 3.

# We need odd, an immediate template should inline it I think.
# SomeInteger is a type class matching all integer types in Nim.
template odd(x: SomeInteger): bool {.immediate.} =
  (x and 1) == 1

# And then we can write it like this using the lambda macro.
# For filter we don't need to declare type for x, but for map we do.
# I suspect this is because we start out with a literal from which
# type is inferenced one level.
var q = @[1,2,3,4,5].filter((x) => x.odd).map((x:int) => x * 3)
echo(q)

# Or procs style, slightly longer and also needing return type of procs.
# Here we get away without declaring x:int, turning the code into generic procs.
# Andreas would call it "bad style" I think.
q = @[1,2,3,4,5].filter(proc(x): bool = x.odd).map(proc(x): int = x * 3)
echo(q)

# #(1 2 3 4) sum
# Sum is already defined in math module
from math import sum
echo(@[1,2,3,4,5].sum)


# #(one two three two four) copyWithoutAll: #(one two)
# The above creates a new collection without any ones or twos.
# One and two are symbols (canonical strings)

# We need copyWithoutAll:, let's call it filterWithout.
# In Nim we don't need "All" to imply that the argument
# should be a collection, we can overload for other types.

# accumulateResult is a template taking an iterator.
# sequtils both has a filter iterator and a filter proc, here
# we use the iterator. This means both the accumulation and the iteration
# will be inlined. I think :)
#
# `notin` is a template which is sugar for `not seq2.contains(x)`
# It is also marked as a keyword so `x.notin(seq2)` does not compile, it needs
# to be `x notin seq2`
proc filterWithout*[T](seq1, seq2: seq[T]): seq[T] =
  accumulateResult(filter(seq1, proc(x:T):bool = x notin seq2))

var qq = @["one", "two", "three", "two", "four"].filterWithout(@["one", "two"])
echo($qq)

# #(1 2 3 4) includesAny: #(1 2)
# #(1 2 3 4) includesAll: #(1 2)
# Both the above can be added easily similar to allSatisfy, anySatisfy:

proc containsAny*[T](seq1, seq2: seq[T]): bool =
  ## Returns true if any of the items in seq2 is in seq1.
  ##
  ## Example:
  ##
  ## .. code-block::
  ##   let numbers = @[10, 20, 30]
  ##   assert numbers.containsAny(@[5, 10])
  result = false
  for i in seq2:
    if i in seq1: return true

proc containsAll*[T](seq1, seq2: seq[T]): bool =
  ## Returns true if all of the items in seq2 are in seq1.
  ##
  ## Example:
  ##
  ## .. code-block::
  ##   let numbers = @[10, 20, 30]
  ##   assert numbers.containsAll(@[10, 20])
  result = true
  for i in seq2:
    if i notin seq1: return false

assert(@[1,2,3,4].containsAll(@[1,2]))
assert(@[1,2,3,4].containsAny(@[1,2,20]))
