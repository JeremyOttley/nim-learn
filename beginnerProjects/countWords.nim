import strutils

proc countString(s: string): int =
  result = s.split(' ').len

when isMainModule:
  countString(readLine(stdin))
