import bottle
from modelpravi import *
from datetime import date
from random import *

@bottle.get('/')
def uporabnik():
    return bottle.template('zacetna_stran.tpl', login = True)

@bottle.post('/prijava/')
def prijavi_se():
    racunid = bottle.request.forms.racunid
    bottle.response.set_cookie("racunid",racunid, path="/")
    return bottle.redirect('/prijava/')

@bottle.get('/prijava/')
def prijavi_se_rezultat():
    return bottle.redirect('/domaca_stran/')

@bottle.get('/registracija/')
def registriraj_se():
    return bottle.template('registracija.tpl')
    
@bottle.post('/registriran/')
def registriran():
    ime_priimek = bottle.request.forms.ime_priimek
    bottle.response.set_cookie("ime_priimek",ime_priimek, path="/")
    racunid = randint(10000, 20000)
    print(str(racunid))
    bottle.response.set_cookie("racunid",str(racunid), path="/")
    ustvari_racun(racunid, ime_priimek) 
    return bottle.redirect('/registriran/')

@bottle.get('/registriran/')
def registriran_rezultat():
    return bottle.redirect('/domaca_stran/')
            
@bottle.get('/<tip>')
def dodaj_trans_tip(tip):
    return bottle.template('dodaj_trans.tpl', tip=tip, seznamK=Kategorija().getSeznamKategorij(tip))

@bottle.get('/domaca_stran/')
def domaca_stran():
    ime_priimek = bottle.request.get_cookie("ime_priimek")
    racunid = bottle.request.get_cookie("racunid")
    racun = naloziRacun(racunid)
    print(racunid)
    if racun is None:
        return bottle.template('zacetna_stran.tpl', login = False)
    ime_priimek = racun.lastnik
    meseci = imena_mesecev
    cas = date.today().strftime("%d-%m-%y")
    return bottle.template('domaca_stran.tpl', seznamT=racun.seznam_transakcij, total=racun.stanje, meseci = meseci, cas = cas, ime_priimek = ime_priimek, racunid = racunid)

@bottle.get('/domaca_stran/odjava/')
def odjavi_me():
    bottle.response.delete_cookie("racunid", path="/")
    bottle.response.delete_cookie("ime_priimek", path="/")
    return bottle.redirect("/")

@bottle.post('/dodaj_transakcijo')
def dodaj_transakcijo():
    racunid = int(bottle.request.get_cookie("racunid"))
    znesek = int(bottle.request.forms.znesek)
    tip = bottle.request.forms.tip
    kategorija = bottle.request.forms.kategorija
    komentar = bottle.request.forms.komentar
    trans = Transakcija(znesek,tip,kategorija,komentar)
    racun=naloziRacun(racunid)
    racun.dodaj_transakcijo(trans)
    shraniRacun(racun)
    bottle.redirect("/dodaj_transakcijo")

@bottle.get('/dodaj_transakcijo')
def dodaj_transakcijo_rezultat():
    bottle.redirect("/domaca_stran/")

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
    ali_je_limit_presezen = opozorilo(racun, racun.slovar_opozoril, leto, mesec)
    slovar_opozoril = racun.slovar_opozoril 
    return bottle.template("analiza.tpl", slovar_zapravljeno = slovar_zapravljeno, slovar_zasluzeno = slovar_zasluzeno, mesec = mesec, leto = leto, meseci = meseci, skupaj_odhodki = skupaj_odhodki, skupaj_prihodki = skupaj_prihodki, slovar_procentov_odhodek = slovar_procentov_odhodek, slovar_procentov_prihodek = slovar_procentov_prihodek, ali_je_limit_presezen = ali_je_limit_presezen, slovar_opozoril = slovar_opozoril)
   
@bottle.get('/seznam_transakcij/')
def get_seznam_transakcij():
    racun=naloziRacun(int(bottle.request.get_cookie("racunid")))
    seznamT = racun.seznam_transakcij
    return bottle.template('transakcije.tpl', seznamT = seznamT)

@bottle.get('/opozorilo/')
def opozorilo_pridobi_kategorijo():
    seznamK = Kategorija().getSeznamKategorij("Odhodek")
    return bottle.template('nastavi_opozorilo.tpl', seznamK = seznamK)


@bottle.post('/nastavi_opozorilo/')
def nastavi_opozorilo_v_slovar():
    limit = bottle.request.forms["limit"]
    kategorija_limit = bottle.request.forms.kategorija_limit
    racun = naloziRacun(int(bottle.request.get_cookie("racunid")))
    racun.nastavi_opozorilo(limit, kategorija_limit)
    shraniRacun(racun)
    return bottle.redirect('/nastavi_opozorilo/')

@bottle.get('/nastavi_opozorilo/')
def opozorilo_rezultat():
   return bottle.template('uspesna_nastavitev_odstranitev.tpl', nastavi = True)

@bottle.get('/opozorilo/odstrani_opozorilo/')
def pridobi_kategorije():
    seznamK = Kategorija().getSeznamKategorij("Odhodek")
    return bottle.template('odstrani_opozorilo.tpl', seznamK = seznamK)

@bottle.post('/odstranjeno/')
def odstrani():
    kategorija_limit = bottle.request.forms.kategorija_limit
    racun = naloziRacun(int(bottle.request.get_cookie("racunid")))
    racun.odstrani_opozorilo(kategorija_limit)
    shraniRacun(racun)
    return bottle.redirect('/odstranjeno/')

@bottle.get('/odstranjeno/')
def odstrani_rezultat():
    return bottle.template('uspesna_nastavitev_odstranitev', nastavi = False)



    

@bottle.get('/img/<ime>')
def slike(ime):
   return bottle.static_file(ime, root = 'img')



bottle.run(reloader=True, debug=True)