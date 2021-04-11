import os

proc main(): int =
  result = 1
  
  if paramCount() != 1:
    echo "pass a single media file as argument"
    return

#
# DO STUFF
#

system.quit(main())
