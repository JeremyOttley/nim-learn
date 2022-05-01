import os, httpclient

proc retrieve(url: string): string =
  var browser = newHttpClient()
  var response = browser.request(url)
  result = response.body

# url contents to file

proc retrieve(url, filename: string): int =
  var browser = newHttpClient()
  var response = browser.request(url)
  writeFile(filename, response.body)
  result = 1
