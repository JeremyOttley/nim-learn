import strutils # join()
import sequtils # @ (to seq)
import algorithm # reversed()

var userInput = readLine(stdin)

func reverseString(s: string): string =
  @s.reversed.join("")

when isMainModule:
  stdout.writeLine(userInput  & " reversed is: " & reverseString(userInput))
