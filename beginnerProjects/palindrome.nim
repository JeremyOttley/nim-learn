import algorithm
import strutils
import sequtils

var userInput = readLine(stdin)

func isPalindrome(s: string): bool =
  var origString = @s.filterIt(it != ' ').join
  var reversedString = s.toLower.filterIt(it != ' ').reversed.join()
  origString == reversedString

when isMainModule:
  echo isPalindrome(userInput)
