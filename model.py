import datetime
import json

from datetime import date
danes = date.today()
leto = danes.year
mesec = danes.month
dan = danes.day

def novo_leto(danes):
    if dan == 1 and mesec == 1:
        return True
    
def nov_mesec(danes):
    return dan == 1

   
#class Model:
    #nalozi, shrani! definiraj (dump, load)

slovar_kategorij_odhodek = {"Hrana" : 0, "Obleka": 0, "Prosti čas": 0, "Transport": 0, 
        "Dom": 0, "Položnice": 0, "Zdravstvene storitve": 0, "Potovanja": 0
        , "Osebna nega": 0, "Zavarovanja": 0, "Najemnina": 0
        , "Telekomunikacijske storitve": 0, "Krediti": 0, "Ostalo": 0}
    
slovar_kategorij_dohodek = {"Plača": 0, "Štipendija": 0, "Honorar": 0, "Posojilo": 0, 
        "Žepnina": 0, "Pokojnina": 0, "Pasivni dohodki (najemnine itd.)": 0,
        "Nagrada": 0, "Ostalo": 0}

class Racun:

    def __init__(self, stanje, slovar_kategorij_dohodek, slovar_kategorij_odhodek, st_racuna):
        self.stanje = 0
        self.slovar_kategorij_dohodek =  slovar_kategorij_dohodek
        self.slovar_kategorij_odhodek = slovar_kategorij_odhodek
        self.st_racuna = st_racuna
        self.transakcije = Transakcija()
    
    def __repr__(self):
        return "Račun: stanje {0}, uporabnik {1}".format(self.stanje, self.uporabnik)
    
    def __str__(self):
        return "Stanje na računu, uporabnika {0}: {1}".format(self.stanje, self.uporabnik)
    
    #ALI BOM SPLOH RABILA TE DVE??? PREGLEJ Z DEF KATEGORIJA!!
    def uspesen_odhodek(self, stevilo):
        if stevilo < self.stanje:
            return True
        else:
            return False

    def uspesen_dohodek(self, stevilo):
        return True

    def dodaj_odhodek(self, stevilo):
        if self.uspesen_odhodek(stevilo):
            self.stanje -= stevilo
            return self.stanje
        else:
            return False

    def dodaj_dohodek(self, stevilo):
        self.stanje += stevilo
        return self.stanje

    def kategorija_dodaj_dohodek(self, stevilo, kategorija):
        self.slovar_kategorij_dohodek[kategorija] = self.slovar_kategorij_dohodek.get(kategorija, 0) + stevilo
        self.stanje += stevilo
        return self.stanje

    def kategorija_dodaj_odhodek(self, stevilo, kategorija):
        if self.uspesen_odhodek(stevilo):
            self.slovar_kategorij_odhodek[kategorija] = self.slovar_kategorij_odhodek.get(kategorija, 0) + stevilo
            return self.stanje
        else:
            return False

    def procentualno_zapravljeno_kategorija_mesec(self, slovar_kategorij_odhodek):
        slovar_procentov = {None: 0}
        for kategorija in slovar_kategorij_odhodek.keys():
            suma = sum(slovar_kategorij_odhodek.values())
            zapravljeno = slovar_kategorij_odhodek.get(kategorija)
            odst = ((zapravljeno / suma) * 100, 2)
            slovar_procentov[kategorija] = odst
            slovar_procentov.pop(None)
        return slovar_procentov


    #def procentualno_po_kategoriji_leto(self):
        

    def procentualno_koliko_mi_ostalo_mesec(self):
        odhodek_mesec = sum(self.slovar_kategorij_odhodek.values())
        prihodek_mesec = sum(self.slovar_kategorij_dohodek.values())
        return round(((prihodek_mesec - odhodek_mesec) / prihodek_mesec) * 100, 2)

    def procentualno_koliko_sem_zapravil_mesec(self):
       ost = self.procentualno_koliko_mi_ostalo_mesec
       return 100 - ost

    def opozorilo_deset(self):
        return self.procentualno_koliko_mi_ostalo_mesec < 10

    #def procentualno_po_kategoriji_leto(self):

    def custom_limit(self, kategorija, limit):
        if self.slovar_kategorij_odhodek[kategorija]  > limit:
            return True
        else:
            return False
    
    #def razlika_prihranki_prejsnji_mesec(self):
        
   
    #povprecje_prihodek(self):
        
    
    #def povprecje_outcome(self):
        

    def dodaj_trajnik(self, datum, stevilo, kategorija):
        if dan == datum and kategorija in self.slovar_kategorij_dohodek.keys():
            return self.kategorija_dodaj_dohodek(stevilo, kategorija)
        elif dan == datum and kategorija in self.slovar_kategorij_odhodek.keys():
            return self.kategorija_dodaj_odhodek
        else:
            pass

            
        

    #def nov_mesec(self, se_nekaj):
        #!
        #za razmisliti, bo treba poklicati nov_mesec, ko pride prvi, da bi se averagi delali na novo po mesecih

   
    #def opozorilo_nastavljeni_limit():
        #nastavili sami limit in bomo prekoračili
    
        
#class Uporabnik:
#???

class Transakcija:
    def __init__(self, cas, znesek, tip, kategorija, komentar):
        self.cas = datetime.datetime.now()
        self.znesek = znesek 
        self.tip = tip
        self.kategorija = kategorija
        self.komentar = komentar


%rebase ('bootstrap.tpl')
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vodenje osebnih financ</title>
    <style>
        body {
            position: relative;
            height: 100vh;
            display: flex;
            margin: 0;
            font-family: sans-serif;
        }
    </style>
</head>
    <body>
        {{ !base }}
    </body>
