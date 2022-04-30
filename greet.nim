proc getUsername: string =
  stdout.write("Your username: ")
  result = stdin.readLine()
  
let username = getUsername()
echo("Your username is ", username)
