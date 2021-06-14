import os, httpclient

proc retrieve(url, filename: string): int =
  var browser = newHttpClient()
  var response = browser.request(url)
  writeFile(filename, response.body)
  result = 1
