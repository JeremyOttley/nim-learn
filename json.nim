import json

type
  Person = object
    age: int
    name: string

var p = Person(age: 32, name: "Gillian")

echo(%p)

### read from json file into JsonNode

proc readJsonFile(filePath: string): JsonNode =
  parseJson(readFile(filePath))
  
### GET json endpoint with httpclient

proc jretrieve(url: string): JsonNode =
  var browser = newHttpClient()
  var response = browser.request(url)
  result = parseJson(response.body)
