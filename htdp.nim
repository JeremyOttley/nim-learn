# Design the function string-first, which extracts the first character from a non-empty string. Don’t worry about empty strings.

func stringFirst(s: string): char =
  @s[0]

var userInput = readLine(stdin)

when isMainModule:
  echo "The first char of " & userInput & " is: " & stringFirst(userInput)

# Design the function string-last, which extracts the last character from a non-empty string.

func stringLast(s: string): char =
  @s[s.high]

var userInput = readLine(stdin)

when isMainModule:
  echo "The last char of " & userInput & " is: " & stringLast(userInput)

# Design the function string-rest, which produces a string like the given one with the first character removed.

# Design the function string-remove-last, which produces a string like the given one with the last character removed.
