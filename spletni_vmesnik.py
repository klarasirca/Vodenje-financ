import bottle
from modelpravi import *
from datetime import date

@bottle.get('/')
def uporabnik():
    return bottle.template('zacetna_stran.tpl')


            
@bottle.get('/<tip>')
def main_screen_selected(tip):
    return bottle.template('dodaj_trans.tpl', tip=tip, seznamK=Kategorija().getSeznamKategorij(tip))

@bottle.get('/domaca_stran/')
def main_screen():
    ime_priimek = bottle.request.get_cookie("ime_priimek")
    if ime_priimek is None:
        ime_priimek = (bottle.request.query["ime_priimek"])
        bottle.response.set_cookie("ime_priimek",ime_priimek, path="/domaca_stran")
    racun=naloziRacun(int(bottle.request.get_cookie("racunid")))
    meseci = imena_mesecev
    cas = date.today().strftime("%m-%d-%y")
    return bottle.template('domaca_stran.tpl', seznamT=racun.seznam_transakcij, total=racun.stanje, meseci = meseci, cas = cas, ime_priimek = ime_priimek)


@bottle.get('/racun/<n:int>')
def get_racun(n):
    n = int(n)
    bottle.response.set_cookie("racunid",str(n), path="/")
    bottle.redirect("/")

@bottle.post('/dodaj_transakcijo')
def dodaj_transakcijo():

    racunid = int(bottle.request.get_cookie("racunid"))
    znesek = int(bottle.request.forms.znesek)
    tip = bottle.request.forms.tip
    kategorija = bottle.request.forms.kategorija
    komentar = bottle.request.forms.komentar

    print(kategorija)
    trans = Transakcija(znesek,tip,kategorija,komentar)
    racun=naloziRacun(racunid)
    Racun.dodaj_transakcijo(racun, trans)
    shraniRacun(racun)
    bottle.redirect("/dodaj_transakcijo")

@bottle.get('/dodaj_transakcijo')
def dodaj_transakcijo_rezultat():
    bottle.redirect("/")

@bottle.get('/pridobi_kategorije/<tip>')
def pridobi_kategorije(tip):
    return obj2json(Kategorija().getSeznamKategorij(tip))

@bottle.get('/analiza_podatkov/')
def analiza_podatkov():
    racunid = int(bottle.request.get_cookie("racunid"))
    racun = naloziRacun(racunid)
    mesec = int(bottle.request.query["mesec"])
    leto = int(bottle.request.query["leto"])
    slovar_zapravljeno = koliko_kategorija(racun, "Odhodek", leto, mesec)
    slovar_zasluzeno = koliko_kategorija(racun, "Dohodek", leto, mesec)
    meseci = imena_mesecev
    skupaj_odhodki = skupaj_prihodki_odhodki(racun, "Odhodek", leto, mesec)
    skupaj_prihodki = skupaj_prihodki_odhodki(racun, "Dohodek", leto, mesec)
    slovar_procentov_odhodek = procentualno_kategorija(racun, "Odhodek", leto, mesec)
    slovar_procentov_prihodek = procentualno_kategorija(racun, "Dohodek", leto, mesec)
    return bottle.template("analiza.tpl", slovar_zapravljeno = slovar_zapravljeno, slovar_zasluzeno = slovar_zasluzeno, mesec = mesec, leto = leto, meseci = meseci, skupaj_odhodki = skupaj_odhodki, skupaj_prihodki = skupaj_prihodki, slovar_procentov_odhodek = slovar_procentov_odhodek, slovar_procentov_prihodek = slovar_procentov_prihodek)
   
@bottle.get('/seznam_transakcij/')
def get_seznam_transakcij():
    racun=naloziRacun(int(bottle.request.get_cookie("racunid")))
    seznamT = racun.seznam_transakcij
    return bottle.template('transakcije.tpl', seznamT = seznamT)

bottle.run(reloader=True, debug=True)