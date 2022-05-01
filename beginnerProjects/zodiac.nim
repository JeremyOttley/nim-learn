import strutils
import xmltree
import httpclient
import q

const
  base: string = "https://www.astrology.com/horoscope/daily"
  aries: string = "aries"
  taurus: string = "taurus"
  gemini: string = "gemini"
  cancer: string = "cancer"
  leo: string = "leo"
  virgo: string = "virgo"
  libra: string = "libra"
  scorpio: string = "scorpio"
  sagittarius: string = "sagittarius"
  capricorn: string = "capricorn"
  aquarius: string = "aquarius"
  pisces: string = "pisces"

template toZodiacUrl(sign: string): string = 
  base & "/" & sign & ".html"

proc query() =
  stdout.writeLine("Hey baby, what's your sign?: ", "\n")

proc getFortune(sign: string): string =
  let client = newHttpClient()
  let response = client.get(toZodiacUrl(sign))
  var doc = q(response.body)
  var pagetext = doc.select("p")
  echo "\n", capitalizeAscii(sign) & ": ", "\n", pagetext[1].innerText

#echo pagetext[1].innerText

when isMainModule:
  query()
  var sign = readLine(stdin)
  case sign:
  of "aries":
    echo getFortune(aries)
  of "taurus":
    echo getFortune(taurus)
  of "gemini":
    echo getFortune(gemini)
  of "cancer":
    echo getFortune(cancer)
  of "leo":
    echo getFortune(leo)
  of "virgo":
    echo getFortune(virgo)
  of "libra":
    echo getFortune(libra)  
  of "scorpio":
    echo getFortune(scorpio)
  of "sagittarius":
    echo getFortune(sagittarius)
  of "capricorn":
    echo getFortune(capricorn)
  of "aquarius":
    echo getFortune(aquarius)
  of "pisces":
    echo getFortune(pisces)
  else:
    echo "Is that a real sign?! Try again."
