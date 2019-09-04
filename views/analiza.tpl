% rebase('bootstrap')

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vodenje osebnih financ</title>
    <script>src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
    </script>
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC|Montserrat&display=swap" rel="stylesheet">

    <style>


            body {
            position: relative;
            height: 100vh;
            margin: 0;
            font-family: 'Montserrat', sans-serif;
            background-color: #FFFFFB}

        h1 {font-family: 'Amatic SC', cursive;font-size: 40px;padding-top: 25px;}
        h3 {font-family: 'Amatic SC', cursive;font-size: 40px;padding-top: 15px;}
        h5 {font-family: 'Montserrat', sans-serif;font-size: 20px;padding-top: 15px;}
        h4 {font-family: 'Montserrat', sans-serif;font-size: 20px;padding-top: 15px; alignment: Alignment.topRight}
        footer {font-family: 'Montserrat', sans-serif;position: absolute;bottom: 0;width: 100%;height: 2.5rem;}
    </style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {packages: ['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      // Define the chart to be drawn.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Kategorija');
      data.addColumn('number', 'Zesek');
      %for kategorija in slovar_zapravljeno.keys():
      data.addRows([
        ['{{kategorija}}', {{slovar_zapravljeno[kategorija]}}],
      ]);
      %end

      // Instantiate and draw the chart.
      var chart = new google.visualization.PieChart(document.getElementById('myPieChart'));
      chart.draw(data, null);
    }
  </script>

</head>




<body>
<div align="center">
% if mesec == 0:
<h1> Statistika za obdobje: Leto {{leto}} </h1>
%else:
<h1> Statistika za obdobje: {{meseci[mesec - 1]}}  {{leto}} </h1>
%end
</div>


<h5>Opozorila:</h5>
% if opozorilo_nastavljeno:
<p>Pod kategorijo {{kategorija_limit}} ste presegli znesek {{limit}} EUR!</p>
% else:
<p>Ni opozoril</p>
%end


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


<div id="myPieChart"/>


</body>