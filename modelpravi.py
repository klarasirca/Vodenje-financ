import json
import datetime
from enum import IntEnum
from collections import namedtuple

def _json_object_hook(d): return namedtuple('X', d.keys())(*d.values())
def json2obj(data): return json.loads(data, object_hook=_json_object_hook)
def obj2json(object): return json.dumps(object, default=lambda obj: obj.__dict__)

class TipTransakcije(IntEnum):
    ODHODEK = 0
    DOHODEK = 1  

class Kategorija:

    seznam_kategorij_odhodek = ["Hrana", "Obleka", "Prosti čas", "Transport", 
        "Dom", "Položnice", "Zdravstvene storitve", "Potovanja"
        , "Osebna nega", "Zavarovanja", "Najemnina"
        , "Telekomunikacijske storitve", "Krediti", "Ostalo"]

    seznam_kategorij_dohodek = ["Plača", "Štipendija", "Honorar", "Posojilo", 
            "Žepnina", "Pokojnina", "Pasivni dohodki (najemnine itd.)",
            "Nagrada", "Ostalo"]

    def getSeznamKategorij(self, tip: TipTransakcije):
        if(tip==TipTransakcije.ODHODEK):
            return self.seznam_kategorij_odhodek
        else:
            return self.seznam_kategorij_dohodek

class Transakcija:
    def __init__(self, znesek, tip: TipTransakcije, kategorija, komentar):
        self.cas = datetime.datetime.now().timestamp()
        self.znesek = znesek 
        self.tip = tip
        self.kategorija = kategorija
        self.komentar = komentar


class Racun:

    def __init__(self, id, stanje=0, seznam_transakcij=[]):
        self.id = id
        self.stanje = stanje
        self.seznam_transakcij: list = seznam_transakcij

    @staticmethod    
    def dodaj_transakcijo(racun, transakcija: Transakcija):
        racun.seznam_transakcij.append(transakcija)
        
        if(transakcija.tip==TipTransakcije.ODHODEK):
            racun.stanje-=transakcija.znesek
        else:
            racun.stanje+=transakcija.znesek
            
    
    #funkcije za analitiko
    
     def koliko_zapravljeno_kategorija(self, obdobje_mesec, obdobje_leto):
        slovar_kategorija = {"Skupaj odhodki": 0, "Skupaj prihodki": 0}
        for transakcija in self.seznam_transakcij:
            cas_normalno = dt.fromtimestamp(transakcija[0])
            leto = cas_normalno.year
            mesec = cas_normalno.month
            if mesec == obdobje_mesec and leto == obdobje_leto:
                kategorija_st = transakcija[3]
                tip = transakcija[2]
                sez_kat = Kategorija().getSeznamKategorij(tip)
                kat = sez_kat[kategorija_st]
                slovar_kategorija[kat] = slovar_kategorija.get(kat, 0) + transakcija[1]
                if tip == 0:
                    slovar_kategorija["Skupaj odhodki"] = slovar_kategorija.get("Skupaj odhodki", 0) + transakcija[1]
                else:
                    slovar_kategorija["Skupaj prihodki"] = slovar_kategorija.get("Skupaj prihodki", 0) + transakcija[1]
        return slovar_kategorija 
        #predelati potrebno po času

def shraniRacun(racun: Racun):
    jsonRacun = obj2json(racun)
    with open("racun_"+str(racun.id)+".json", "w+") as file:
        file.write(jsonRacun)

def naloziRacun(racunId: int):
    jsonRacun = ""
    with open("racun_"+str(racunId)+".json", "r") as file:
        jsonRacun=file.read()
    obj_racun=json2obj(jsonRacun)
    return Racun(obj_racun.id, obj_racun.stanje, obj_racun.seznam_transakcij)
