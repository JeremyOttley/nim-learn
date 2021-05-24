import re

let 
  expr = re"^(Screenshot\\sfrom)\\s(\\d{4}-\\d{2}-\\d{2})\\s"
  
var 
  matches: array[2, string]

if "Screenshot from 2021-05-23 19-42-38.png".find(expr, matches) >= 0:
  echo matches
  
#=> ["Screenshot from", "2021-05-23"]
