% rebase('osnova')
<div style="flex: 1">
Dodaj transakcijo: <select onchange="if (this.value) window.location.href='/'+this.value">
                        <option value="-1">Izberi</option>
                        <option value="1">Dohodek</option>
                        <option value="0">Odhodek</option>
                </select><br>
</div>
<div style="flex: 1">
Na računu: 
{{ total }}<br>
Transakcije:
<br>
<table style="width: 100%">
  <tr>
    <th>Znesek</th>    
    <th>Tip</th> 
    <th>Kategorija</th> 
    <th>Datum</th>
    <th>Komentar</th>

  </tr>
  
  % for trans in enumerate(seznamT):
    <tr>
    <td>{{ trans[1][1] }}</td>
    <td>{{ trans[1][2] }}</td>
    <td>{{ trans[1][3] }}</td>
    <td>{{ trans[1][0] }}</td>
    <td>{{ trans[1][4] }}</td>
    </tr>
  % end
</table>
</div>

