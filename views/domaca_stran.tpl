% rebase('osnova')
% from datetime import datetime

<div style="flex: 1">

Dodaj transakcijo: <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Izberi
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/Dohodek">Dohodek</a>
    <a class="dropdown-item" href="/Odhodek">Odhodek</a>
  </div>
</div>

Analiza podatkov za:
<form action="/analiza_podatkov/">
  mesec: <select name="mesec">
%for mesec in meseci:
    <option value = {{meseci.index(mesec) + 1}}>{{mesec}}</option>
%end
            </select>
  leto: <input type="number" name="leto" value = leto>
  <input type="submit" value="submit">
</form>



Na računu: 
{{ total }}<br>


<p class="h4">Transakcije:</p>
<br>
<table class="table">
  <tr>
    <th>Znesek</th>    
    <th>Tip</th> 
    <th>Kategorija</th> 
    <th>Datum</th>
    <th>Komentar</th>

  </tr>
  
  % for trans in seznamT:
    <tr>
    <td>{{ trans['znesek']}} € </td>
    <td>{{ trans['tip'] }}</td>
    <td>{{ trans['kategorija'] }}</td>
    <td>{{ datetime.fromtimestamp(trans['cas']).strftime("%d.%m.%Y %H:%M:%S") }}</td>
    <td>{{ trans['komentar'] }}</td>
    </tr>
  % end
</table>
</div>

