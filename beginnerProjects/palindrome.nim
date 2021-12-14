import algorithm
import strutils

var userInput = readLine(stdin)

proc isPalindrome(s: string): bool =
  result = s.toLower == s.toLower.reversed.join()


when isMainModule:
  echo isPalindrome(userInput)
