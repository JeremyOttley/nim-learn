import json

type
  Person = object
    age: int
    name: string

var p = Person(age: 38, name: "Torbjørn")

echo(%p)
