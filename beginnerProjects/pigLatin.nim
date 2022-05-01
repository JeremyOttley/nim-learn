import strutils
import sequtils
import algorithm

var userInput = readLine(stdin)

func addSuffix(s: string): string =
  s & "ay"
  
template pLatinize(s: string): string {. discardable .} =
  addSuffix(toSeq(s).rotatedLeft(1).join)

when isMainModule:
  stdout.writeLine(userInput & " in Pig Latin is: " & pLatinize(userInput))
