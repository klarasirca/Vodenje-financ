import bottle
from modelpravi import *
            
@bottle.get('/<n:int>')
def main_screen_selected(n):
    print(n)
    
    return bottle.template('mainscreen.tpl', tip=n, seznamK=Kategorija().getSeznamKategorij(n))

@bottle.get('/')
def main_screen():
    racun=naloziRacun(int(bottle.request.get_cookie("racunid")))

    return bottle.template('main.tpl',seznamT=racun.seznam_transakcij, total=racun.stanje)


@bottle.get('/racun/<n:int>')
def get_racun(n):
    n = int(n)
    bottle.response.set_cookie("racunid",str(n), path="/")
    bottle.redirect("/")

@bottle.post('/dodaj_transakcijo')
def dodaj_transakcijo():

    racunid = int(bottle.request.get_cookie("racunid"))
    znesek = int(bottle.request.forms.znesek)
    tip = int(bottle.request.forms.tip)
    kategorija = int(bottle.request.forms.kategorija)
    komentar = bottle.request.forms.komentar

    trans = Transakcija(znesek,tip,kategorija,komentar)
    racun=naloziRacun(racunid)
    Racun.dodaj_transakcijo(racun, trans)
    shraniRacun(racun)
    bottle.redirect("/dodaj_transakcijo")

@bottle.get('/dodaj_transakcijo')
def dodaj_transakcijo_rezultat():
    bottle.redirect("/")

@bottle.get('/pridobi_kategorije/<n:int>')
def pridobi_kategorije(n):
    return obj2json(Kategorija().getSeznamKategorij(n))

@bottle.get('/analiza_podatkov')
def analiza_podatkov():
    racunid = int(bottle.request.get_cookie("racunid"))
    racun=naloziRacun(racunid)
    mesec = int(bottle.request.query["mesec"])
    leto = int(bottle.request.query["leto"])
    slovar = racun.koliko_zapravljeno_kategorija(mesec, leto)
    for kategorija in slovar.keys():
        if kategorija in Kategorija().getSeznamKategorij(0):
            print("Pod kategorijo {0} si {1} leta {2} zapravil/a {3} EUR.".format(kategorija, mesec, leto, slovar[kategorija]))
        else:
            print("Pod kategorijo {0} si {1} leta {2} zaslužil/a {3} EUR.".format(kategorija, mesec, leto, slovar[kategorija]))


if __name__ == '__main__':
    bottle.run(reloader=True, debug=True)
