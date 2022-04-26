import nake
import os

let examples = ["usage.nim"]

task "examples", "Build examples":
  for example in examples:
    direShell(nimExe, "c", "examples"/example)

task "clean", "Clean generated files":
  for example in examples:
    let name = example.changeFileExt(ExeExt)
    removeFile("examples"/name)

  removeFile("nakefile")
