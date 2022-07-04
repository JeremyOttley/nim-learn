import times
import os

template backupFileName(filename: string): string =
  now().format("dd-MM-yyyy") & "-" & filename

proc moveBackup(file: string): int {. discardable .} =
  copyFileWithPermissions(file, backupFileName(file))
  return 1

when isMainModule:
  for command in commandLineParams():
    moveBackup(command)
