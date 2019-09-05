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
        #overlay {position: fixed; z-index: 2;}
    </style>


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {packages: ['corechart']});
    google.charts.setOnLoadCallback(drawChartOdhodki);
    google.charts.setOnLoadCallback(drawChartPrhodki);

    function drawChartOdhodki() {
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
      var chart = new google.visualization.PieChart(document.getElementById('myPieChartOdhodki'));
      chart.draw(data, null);
    }

    function drawChartPrhodki() {
      // Define the chart to be drawn.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Kategorija');
      data.addColumn('number', 'Zesek');
      %for kategorija in slovar_zasluzeno.keys():
      data.addRows([
        ['{{kategorija}}', {{slovar_zasluzeno[kategorija]}}],
      ]);
      %end

      // Instantiate and draw the chart.
      var chart = new google.visualization.PieChart(document.getElementById('myPieChartPrihodki'));
      chart.draw(data, null);
    }



  </script>


</head>


<div align="center">
% if mesec == 0:
<h1> Statistika za obdobje: Leto {{leto}} </h1>
%else:
<h1> Statistika za obdobje: {{meseci[mesec - 1]}}  {{leto}} </h1>
%end
</div>

<div class="container">
%if slovar_zapravljeno == {} and slovar_zasluzeno == {}:
<div align="center">
<h5> Ni še/bilo dodanih transakcij!</h5>
</div>
%end

<div align="center">
%if ali_je_limit_presezen == []:
<p>Ni opozoril</p>
%else:
<div id= "overlay" class="alert alert-success alert-dismissible fade show" role="alert">
  <h4 class="alert-heading">Opozorila</h4>
  %for kategorija_limit in ali_je_limit_presezen:
<p>Pod kategorijo {{kategorija_limit}} ste presegli znesek {{slovar_opozoril[kategorija_limit]}} EUR!</p>
%end
  <hr>
  <p class="mb-0">Poskušajte zapravljati manj!</p>

  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
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




<table class="columns">
      <tr>
        <td><div id="myPieChartPrihodki"/></td>
        <td><div id="myPieChartOdhodki"/></td>
      </tr>
    </table>

</div>

 