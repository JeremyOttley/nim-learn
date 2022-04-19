import strutils
import sequtils
import algorithm

var userInput = readLine(stdin)

proc addSuffix(s: string): string =
  s & "ay"

proc pLatinize(s: string): string {. discardable .} =
  addSuffix(toSeq(s).rotatedLeft(1).join)

when isMainModule:
  stdout.writeLine(userInput & " in Pig Latin is: " & pLatinize(userInput))
