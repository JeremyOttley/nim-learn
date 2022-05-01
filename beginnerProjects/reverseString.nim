from strutils import join
from sequtils import toSeq
from algorithm import reversed

var userInput = readLine(stdin)

func reverseString(s: string): string =
  @s.reversed.join("")

when isMainModule:
  stdout.writeLine(userInput  & " reversed is: " & reverseString(userInput))
