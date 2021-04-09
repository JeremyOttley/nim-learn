#
# NimScript build file for Project X
#

# Switches
switch("verbosity", "0")
switch("hints", "off")

when defined(testing) :
  switch("verbosity", "1")
  switch("hints", "on")

#
# Tasks
#
task tests, "run the test":
  exec "testament pat \"test*.nim\""

task build, "build project":
  exec "nim c main.nim"
  
# Commands:
#
# nim tests
# nim build
