proc query() =
  echo "Who should I greet?"

proc greet(name: string): string =
  "Hello " & name

proc main() =
  query()
  echo greet(readLine(stdin))

main()
