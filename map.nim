## "map" datastructure

import tables

var myMap: Table[string, string] = {"a": "apple", "b": "banana"}.toTable
#myMap.del("a")
#myMap.add("a")


## "map" function

import sequtils

let 
  a = @[1, 2, 3, 4]
  b = a.map(proc(x: int): int = x * 2)

## "map" function with iterator (preferred in nim)

let
  a = @[1, 2, 3, 4]
  b = a.mapIt(4 * it)
