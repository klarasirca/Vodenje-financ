%rebase('osnova')

<div align="center">
<h1>Nastavite opozorilo za določeno kategorijo</h1>

<h5>V kolikor boste presegli znesek, ki si ga nastavite za določeno kategorijio, boste v zavihku analiza o tem obveščeni.</h5>
<h5>Pozor: opozorilo si lahko nastavite le za eno kategorijo naenkrat. Seveda pa jo lahko spreminjate.</h5>


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