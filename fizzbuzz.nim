import strutils

proc FizzBuzz(n: int): int =
  for i in 1..n:
    if i mod 15 == 0:
      echo("FizzBuzz")
    elif i mod 3 == 0:
      echo("Fizz")
    elif i mod 5 == 0:
      echo("Buzz")
    else:
      echo(i)
      
echo FizzBuzz(parseInt(readLine(stdin)))
