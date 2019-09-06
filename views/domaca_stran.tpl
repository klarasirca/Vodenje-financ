% rebase('osnova')
% from datetime import datetime

<div class="container">

<div align="right">
<h5><i class="fas fa-user-circle"></i> {{ime_priimek}} </h5>
<h5><i class="fas fa-list-ol"></i> Številka računa: {{racunid}} </h5>
<h5><i class="fas fa-coins"></i> Na računu: {{ total }} EUR</h5>
</div>

<div class="mx-auto" align="center" style="width: 600px;">
  <h1>Vodenje osebnih financ </h1>
</div>




<div align="center" padding-top:"50px">
<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
  <a href="/seznam_transakcij/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Seznam transakcij</a>
  <div class="btn-group" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-outline-secondary" dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      Dodaj transakcijo
    </button>
   <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/Dohodek">Dohodek</a>
    <a class="dropdown-item" href="/Odhodek">Odhodek</a>
    </div>
  </div>
  <div class="btn-group" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-outline-secondary" dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      Opozorilo
    </button>
   <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/opozorilo/">Nastavi opozorilo</a>
    <a class="dropdown-item" href='/opozorilo/odstrani_opozorilo/'>Odstrani opozorilo</a>
    </div>
  </div>
  <a href="/domaca_stran/odjava/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Odjava</a>
</div>
</div>
 













<h5>Analiza podatkov:</h5>
<form action="/analiza_podatkov/">
 <div class="form-row">
 
  <div class="form-group col-md-4">
  <label for="mesec">Mesec:</label>
  <select name="mesec" class="form-control" required>
    <option value="">Izberi</option>
    <option value = 0>Letna raven</option>
%for mesec in meseci:
    <option value = {{meseci.index(mesec) + 1}}>{{mesec}}</option>
%end
</select>
    </div>
    <div class="form-group col-md-6">
      <label for="inputLeto">Leto:</label>
      <input type="number" name="leto" value="2019" placeholder="Leto" class="form-control" id="inputLeto" max="2050" min="1960" required>
     
    </div>
  </div>
  <input type="submit" class="btn btn-outline-secondary" value="Potrdi">
</form>




</div>






