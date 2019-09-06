import json
import datetime
from datetime import datetime as dt
from enum import IntEnum
import os.path

def json2obj(data): 
    obj_dict = json.loads(data)
    return Racun(**obj_dict)

def obj2json(object): 
    return json.dumps(object, indent = 2, default = lambda obj: obj.__dict__)


imena_mesecev = ["Januar", "Februar", "Marec", "April", "Maj", "Junij", "Julij", "Avgust", "September", "Oktober", "November", "December"]



class Kategorija:

    seznam_kategorij_odhodek = ["Hrana", "Obleka", "Prosti čas", "Transport", 
        "Dom", "Položnice", "Zdravstvene storitve", "Potovanja"
        , "Osebna nega", "Zavarovanja", "Najemnina", 
        "Telekomunikacijske storitve", "Krediti", "Ostalo"]

    seznam_kategorij_dohodek = ["Plača", "Štipendija", "Honorar", "Posojilo", 
            "Žepnina", "Pokojnina", "Najemnina",
            "Nagrada", "Ostalo"]

    def pridobi_seznam_kategorij(self, tip):
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

    def __init__(self,id, lastnik, stanje = 0, seznam_transakcij = [], slovar_opozoril = {}):
        self.lastnik = lastnik
        self.id = id
        self.stanje = stanje
        self.seznam_transakcij = seznam_transakcij
        self.slovar_opozoril = slovar_opozoril
       

      
    def dodaj_transakcijo(self, transakcija: Transakcija):
        self.seznam_transakcij.append(transakcija)
        if transakcija.tip == 'Odhodek':
            self.stanje -= transakcija.znesek
        elif transakcija.tip == 'Dohodek':
            self.stanje += transakcija.znesek

    def nastavi_opozorilo(self, limit, kategorija):
        self.slovar_opozoril[kategorija] = limit

    def odstrani_opozorilo(self, kategorija):
        if kategorija in self.slovar_opozoril:
            del self.slovar_opozoril[kategorija]
        else:
            print("Ni odstranjenega opozorila za kategorijo, saj ni bil nastavljen")


            
def ustvari_racun(id, ime):
    racunTemplate = nalozi_racun("template")
    racunTemplate.id = id
    racunTemplate.lastnik = ime 
    shrani_racun(racunTemplate)



def shrani_racun(racun: Racun):
    json_racun = obj2json(racun)
    with open("racun_" + str(racun.id) + ".json", "w+") as file:
        file.write(json_racun)


def nalozi_racun(racunId):
    if os.path.exists("racun_" + str(racunId) + ".json"):
        json_racun = ""
        with open("racun_" + str(racunId) + ".json", "r") as file:
            json_racun = file.read()
        obj_racun = json2obj(json_racun)
        return obj_racun
    else:
        print("Račun ne obstaja")
        return None

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
        procent = round ((koliko_kat / skupaj) * 100, 3)
        slovar_procentov[kategorija] = procent
    return slovar_procentov

def opozorilo(racun: Racun, slovar_opozoril, obdobje_leto, obdobje_mesec):
    seznam_je_limit_presezen = []
    slovar_kategorij = koliko_kategorija(racun, "Odhodek", obdobje_leto, obdobje_mesec)
    if slovar_kategorij == {}:
        return seznam_je_limit_presezen
    for kategorija in slovar_opozoril:
        if kategorija in slovar_kategorij:
            zapravljeno_pod_kategorijo = slovar_kategorij[kategorija]
            limit = int(slovar_opozoril[kategorija])
            if zapravljeno_pod_kategorijo > limit:
                seznam_je_limit_presezen.append(kategorija)
    return seznam_je_limit_presezen






    