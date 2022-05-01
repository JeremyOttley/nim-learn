# func: no side effects
func add(x, y: int): int =
  x + y

# proc: allows side effects
proc add(x, y: int): string =
  echo(x + y)

# method: dynamic dispatch/objects
