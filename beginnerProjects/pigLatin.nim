import strutils
import sequtils
import algorithm

proc addSuffix(s: string): string =
  result = s & "ay"

proc pLatinize(s: string): string {. discardable .} =
  result = addSuffix(toSeq(s).rotatedLeft(1).join)

when isMainModule:
  echo pLatinize(readLine(stdin))

