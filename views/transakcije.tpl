% rebase('osnova')
% from datetime import datetime

<div style="flex: 1">

  <div align="right">
    <h5>Datum: {{cas}}</h5>
  </div>

  <h3>Transakcije:</h3>
  <br>

  <div align="left">
    <h4><a href="/domaca_stran/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Domov</a></h4>
  </div>

  <table class="table">
    <tr>
      <th>Znesek</th>    
      <th>Tip</th> 
      <th>Kategorija</th> 
      <th>Datum</th>
      <th>Komentar</th>
    </tr>
  
    % for trans in seznam_transakcij:
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