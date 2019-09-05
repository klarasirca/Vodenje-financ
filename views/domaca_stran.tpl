% rebase('osnova')
% from datetime import datetime

<div class="container">

<div align="right">
  <h4><a href="/domaca_stran/odjava/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Odjava</a></h4>
</div>


<div align="left">
<h5>{{cas}}</h5>
</div>

<div class="mx-auto" style="width: 300px;">
  <h1>Vodenje osebnih financ </h1>
</div>

<div align="right">
<h5> Številka računa: {{racunid}} </h5>
<h5> Ime in priimek: {{ime_priimek}} </h5>
<h5>Na računu: {{ total }} EUR</h5>
</div>

<div align="left">
  <h4><a href="/seznam_transakcij/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Seznam transakcij</a></h4>
</div>

<div align="left">
  <h4><a href="/opozorilo/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Nastavi opozorilo</a></h4>
</div>

<div align="left">
<h5> <div class="dropdown">
  <button class="btn btn-outline-secondary" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  Dodaj transakcijo
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/Dohodek">Dohodek</a>
    <a class="dropdown-item" href="/Odhodek">Odhodek</a>
  </div>
</div>
</h5>
</div>

<h5>Analiza podatkov:</h5>
<form action="/analiza_podatkov/">
 <div class="form-row">
 
  <div class="form-group col-md-4">
  <label for="mesec">Mesec:</label>
  <select name="mesec" class="form-control">
    <option selected>Izberi</option>
    <option value = 0>Letna raven</option>
%for mesec in meseci:
    <option value = {{meseci.index(mesec) + 1}}>{{mesec}}</option>
%end
</select>
    </div>
    <div class="form-group col-md-6">
      <label for="inputLeto">Leto:</label>
      <input type="number" name="leto" value = leto class="form-control" id="inputLeto">
    </div>
  </div>
  <input type="submit" class="btn btn-outline-secondary" value="Potrdi">
</form>




</div>






