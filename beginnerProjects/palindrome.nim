import algorithm
import strutils
import sequtils

var userInput = readLine(stdin)

proc isPalindrome(s: string): bool =
  result = @s.filterIt(it != ' ').join == s.toLower.filterIt(it != ' ').reversed.join()

  # @s.filterIt(it != ' ')
when isMainModule:
  echo isPalindrome(userInput)
