import algorithm
import strutils
import sequtils

var userInput = readLine(stdin)

proc isPalindrome(s: string): bool =
  var origString = @s.filterIt(it != ' ').join
  var reversedString = s.toLower.filterIt(it != ' ').reversed.join()
  result = origString == reversedString

when isMainModule:
  echo isPalindrome(userInput)
