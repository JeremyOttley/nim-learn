import times
import os

template backUpName(original: string): string =
  getDateStr() & "-" & original

proc moveBackup(file: string): int {. discardable .} =
  copyFileWithPermissions(file, backUpName(file))
  return 1

when isMainModule:
  moveBackup(stdin.readLine)
