import json
import datetime
from datetime import datetime as dt
from enum import IntEnum

def json2obj(data): 
    obj_dict = json.loads(data)
    return Racun(**obj_dict)

def obj2json(object): 
    return json.dumps(object, indent = 2, default = lambda obj: obj.__dict__)


imena_mesecev = ["januar", "februar", "marec", "april", "maj", "junij", "julij", "avgust", "september", "oktober", "november", "december"]



class Kategorija:

    seznam_kategorij_odhodek = ["Hrana", "Obleka", "Prosti čas", "Transport", 
        "Dom", "Položnice", "Zdravstvene storitve", "Potovanja"
        , "Osebna nega", "Zavarovanja", "Najemnina", 
        "Telekomunikacijske storitve", "Krediti", "Ostalo"]

    seznam_kategorij_dohodek = ["Plača", "Štipendija", "Honorar", "Posojilo", 
            "Žepnina", "Pokojnina", "Najemnina",
            "Nagrada", "Ostalo"]

    def getSeznamKategorij(self, tip):
        if tip == 'Odhodek':
            return self.seznam_kategorij_odhodek
        else:
            return self.seznam_kategorij_dohodek

class Transakcija:
    def __init__(self, znesek, tip, kategorija, komentar):
        self.cas = datetime.datetime.now().timestamp()
        self.znesek = znesek 
        self.tip = tip
        self.kategorija = kategorija
        self.komentar = komentar


class Racun:

    def __init__(self, id, stanje = 0, seznam_transakcij = []):
        self.id = id
        self.stanje = stanje
        self.seznam_transakcij = seznam_transakcij

    @staticmethod    
    def dodaj_transakcijo(racun, transakcija: Transakcija):
        racun.seznam_transakcij.append(transakcija)
        if(transakcija.tip == 'odhodek'):
            racun.stanje -= transakcija.znesek
        else:
            racun.stanje += transakcija.znesek
            


def shraniRacun(racun: Racun):
    jsonRacun = obj2json(racun)
    with open("racun_" + str(racun.id) + ".json", "w+") as file:
        file.write(jsonRacun)

def naloziRacun(racunId):
    jsonRacun = ""
    with open("racun_" + str(racunId) + ".json", "r") as file:
        jsonRacun = file.read()
    obj_racun = json2obj(jsonRacun)
    return obj_racun

#funkcije za analitiko:

def ali_je_transakcija_pravi_cas(transakcija: Transakcija, obdobje_leto, obdobje_mesec = 0):
    cas_normalno = dt.fromtimestamp(transakcija["cas"])
    leto = cas_normalno.year
    mesec = cas_normalno.month
    if obdobje_mesec == 0:
        return leto == obdobje_leto
    else:
        return mesec == obdobje_mesec and leto == obdobje_leto


def koliko_kategorija(racun: Racun, tip, obdobje_leto, obdobje_mesec = 0):
        slovar_kategorija = {}
        for transakcija in racun.seznam_transakcij:
            if ali_je_transakcija_pravi_cas(transakcija, obdobje_leto, obdobje_mesec) and transakcija["tip"] == tip:
                kat = transakcija['kategorija']
                slovar_kategorija[kat] = slovar_kategorija.get(kat, 0) + transakcija["znesek"]
        return slovar_kategorija


def skupaj_prihodki_odhodki(racun: Racun, tip, obdobje_leto, obdobje_mesec):
    slovar_kategorij = koliko_kategorija(racun, tip, obdobje_leto, obdobje_mesec)
    skupaj_tip = 0
    for kategorija in slovar_kategorij:
        znesek = slovar_kategorij[kategorija]
        skupaj_tip += znesek
    return skupaj_tip

def procentualno_kategorija(racun: Racun, tip, obdobje_leto, obdobje_mesec):
    slovar_kategorij = koliko_kategorija(racun, tip, obdobje_leto, obdobje_mesec)
    skupaj = skupaj_prihodki_odhodki(racun, tip, obdobje_leto, obdobje_mesec)
    slovar_procentov = {}
    for kategorija in slovar_kategorij:
        koliko_kat = slovar_kategorij[kategorija]
        procent = round ((koliko_kat / skupaj) * 100, 1)
        slovar_procentov[kategorija] = procent
    return slovar_procentov