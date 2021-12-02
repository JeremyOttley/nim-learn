import strutils
import algorithm

proc reverseString(s: string): string =
  result = s.reversed.join

when isMainModule:
  reverseString(readLine(stdin))
