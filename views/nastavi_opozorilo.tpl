%rebase('osnova')

<div align="center">
<h1>Nastavite opozorilo za določeno kategorijo</h1>

<h5>V kolikor boste presegli znesek, ki si ga nastavite za določeno kategorijio, boste v zavihku analiza o tem obveščeni.</h5>
<h5>Opozorilo lahko spreminjate.</h5>

<div align="left">
  <h4><a href='/opozorilo/odstrani_opozorilo/' class="btn btn-outline-secondary" role="button" aria-pressed="true">Odstrani opozorilo</a></h4>
</div>

<form action="/nastavi_opozorilo/" method="POST">
                <h5>Kategorija: 
                                        <select name = "kategorija_limit" class="form-control-sm">
                                        % for kategorija in seznamK:
                                                <option value="{{ kategorija }}">{{ kategorija }}</option>
                                        % end
                                        </select> <br>
                                </h5>
  <h5> Max znesek: <input type="number"  class="form-control-sm" name="limit" value="limit"> </h5>
  <input class="btn btn-outline-secondary" type="submit" value="Dodaj">
</form>
</div>