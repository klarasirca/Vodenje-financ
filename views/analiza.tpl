% rebase('osnova')


<div align="center">
% if mesec == 0:
<h1> Statistika za obdobje: Leto {{leto}} </h1>
%else:
<h1> Statistika za obdobje: {{meseci[mesec - 1]}}  {{leto}} </h1>
%end
</div>


<div class="table-responsive col-md-6">
<table class="table table-sm">
  <thead class="thead-light">
    <tr>
      <th scope="col">Stroški</th>
      <th scope="col">Kategorija</th>
      <th scope="col">Znesek (v EUR)</th>
      <th scope="col">Odstotek</th>
    </tr>
  </thead>
  <tbody>
%for kategorija in slovar_zapravljeno.keys():
    <tr>
      <th scope="row"></th>
      <td>{{kategorija}}</td>
      <td>{{slovar_zapravljeno[kategorija]}}</td>
      <td>{{slovar_procentov_odhodek[kategorija]}} %</td>
    </tr>
%end
    <tr>
      <th scope="row"></th>
      <td>Skupaj:</td>
      <td>{{skupaj_odhodki}}</td>
      <td>100 %</td>
    </tr>
    
  </tbody>
</table>
</div>

<div class="table-responsive col-md-6">
<table class="table table-sm">
  <thead class="thead-light">
    <tr>
      <th scope="col">Prihodki</th>
      <th scope="col">Kategorija</th>
      <th scope="col">Znesek (v EUR)</th>
      <th scope="col">Odstotek</th>
    </tr>
  </thead>
  <tbody>
%for kategorija in slovar_zasluzeno.keys():
    <tr>
      <th scope="row"></th>
      <td>{{kategorija}}</td>
      <td>{{slovar_zasluzeno[kategorija]}}</td>
      <td>{{slovar_procentov_prihodek[kategorija]}} %</td>
    </tr>
%end
    <tr>
      <th scope="row"></th>
      <td>Skupaj:</td>
      <td>{{skupaj_prihodki}}</td>
      <td>100 %</td>
    </tr>
    
  </tbody>
</table>
</div>