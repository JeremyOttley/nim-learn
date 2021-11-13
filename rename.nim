# this script was used to rename a series of photos used in a project for the Manifold publishing platform

import os, nre

var images: seq[string]

proc collectImages(): int =
  for jpg in walkFiles("*.jpg"):
    images.add(jpg)
  for jpeg in walkFiles("*.jpeg"):
    images.add(jpeg)
  for png in walkFiles("*.png"):
    images.add(png)
  for bmp in walkFiles("*.bmp"):
    images.add(bmp)
  result = 1

for image in images:
  moveFile(image, image.replace(re"\w+_\d+-", ""))
