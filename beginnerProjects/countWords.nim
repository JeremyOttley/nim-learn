import strutils

var userInput = readLine(stdin)

func countString(s: string): int =
  @s.len

when isMainModule:
  stdout.writeLine("The string, " & userInput & " contains " & $countString(userInput) & " letters")
