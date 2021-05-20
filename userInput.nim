proc getUserInput: string =
  stdout.write("Give me input: ")
  result = stdin.readLine()

let response = getUserInput()

echo("Your input is ", response)
