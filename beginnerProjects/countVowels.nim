import nre
from sequtils import toSeq # toSeq collides with nre/toSeq which is different

let vowels = re"[aeoui]"

var userInput = readLine(stdin)

proc hasVowels(s: string): seq[RegexMatch] =
  sequtils.toSeq(s.findIter(vowels))

proc countVowels(s: string): int {. discardable .} =
  sequtils.toSeq(s.findIter(vowels)).len


when isMainModule:
  stdout.writeLine(userInput & " has " & $countVowels(userInput) & " vowels: " & hasVowels(userInput)[0].match & " and " & hasVowels(userInput)[1].match)
