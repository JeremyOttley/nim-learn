import strutils
import sequtils
import algorithm

var userInput = readLine(stdin)

proc addSuffix(s: string): string =
  result = s & "ay"

proc pLatinize(s: string): string {. discardable .} =
  result = addSuffix(toSeq(s).rotatedLeft(1).join)

when isMainModule:
  echo userInput & " in Pig Latin is: " & pLatinize(userInput)
