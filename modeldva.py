import datetime
import json

#class Model:
#json datoteke, uporabnik

class Uporabnik:
    def __init__(self):
        self.geslo = geslo
        self.ime = ime 
        self.racun = racun

class Racun:
    def __init__(self):
        self.stanje = stanje


class Kategorija:
    def __init__(self):
        self.kategorija = kategorija
        self.stanje_kat = stanje_kat
    



class Transakcija:
    def __init__(self, stevilo):
        self.cas = datetime.datetime.now()
        self.stevilo = stevilo