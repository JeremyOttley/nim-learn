import strutils

var userInput = readLine(stdin)

func countString(s: string): int =
  @s.len

when isMainModule:
  echo "The string, " & userInput & " contains " & $countString(userInput) & " letters"
