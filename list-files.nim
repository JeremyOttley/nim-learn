import os
var paths: seq[string] = @[]
for path in walkFiles("*"):
  paths.add path

## OR ##

import os, sequtils

let filesInPath = toSeq(walkDir("path", relative=true))
