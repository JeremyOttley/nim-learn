import strformat
import tables

var myMap = {"a": "apple", "b": "banana"}.toTable

for key, value in myMap:
  echo fmt"key: {key}, value: {value}"
