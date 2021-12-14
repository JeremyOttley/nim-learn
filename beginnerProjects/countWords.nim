import strutils

var userInput = readLine(stdin)

proc countString(s: string): int =
  result = @s.len

when isMainModule:
  echo "The string, " & userInput & " contains " & $countString(userInput) & " letters"
