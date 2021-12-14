import nre
from sequtils import toSeq # toSeq collides with nre/toSeq which is different

let vowels = re"[aeoui]"

let s = sequtils.toSeq("Jeremy".findIter(vowels))

proc countVowels(s: string): int {. discardable .} =
  result = sequtils.toSeq(s.findIter(vowels)).len


when isMainModule:
  echo "Jeremy has: " & $countVowels(readLine(stdin)) & " vowels"
