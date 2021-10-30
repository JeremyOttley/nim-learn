import httpclient
import json

type
  Character = ref object
    thac9: int64
    spell: seq[string]
    ac: int64
    saves: Saves
    attr: Attr
    hp: int64
    to_hit: seq[seq[int64]]
    appearance: string
    system: string
    skills: seq[string] # needs to change to a tuple
    class: string
    languages: seq[string]
    equipment: seq[string]
    attributes: seq[seq[string]]
    notes: seq[string]
    personality: string
  Saves = ref object
    wands: int64
    breath: int64
    stone: int64
    magic: int64
    poison: int64
  Attr = ref object
    DEX: string
    CHA: string
    INT: string
    WIS: string
    STR: string
    CON: string
