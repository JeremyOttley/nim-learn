import strutils # join()
import sequtils # @ (to seq)
import algorithm # reversed()

var userInput = readLine(stdin)

proc reverseString(s: string): string =
  result = @s.reversed.join("")

when isMainModule:
  echo userInput  & " reversed is: " & reverseString(userInput)
