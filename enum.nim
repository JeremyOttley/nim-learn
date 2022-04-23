type
  Card = object
    rank: Rank
    suit: Suit
  Rank = enum
    crSeven
    crEight
    crNine
    crTen
    crJack
    crQueen
    crKing
    crAce
  Suit = enum
    csClubs = "♧"
    csDiamonds = "♢"
    csHearts = "♡"
    csSpades = "♤"
proc `<`(a,b: Card): bool = a.rank < b.rank
when isMainModule:
  let
    aceDiamonds = Card(rank: crAce, suit: csDiamonds)
    kingClubs = Card(rank: crKing, suit: csClubs)
    aceClubs = Card(rank: crAce, suit: csClubs)
