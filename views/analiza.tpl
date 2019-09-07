%rebase ('bootstrap.tpl')
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vodenje osebnih financ</title>
   
    <link href="https://fonts.googleapis.com/css?family=Montserrat|Syncopate&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/be71cc6167.js"></script>

    <style>


      body {
            position: relative;
            height: 100vh;
            margin: 0;
            font-family: 'Montserrat', sans-serif;
            background-color: #FFFFFB}

      h1 {font-family:'Syncopate', sans-serif;font-size: 40px;padding-top: 15px;padding-bottom: 50px}
      h3 {font-family:'Syncopate', sans-serif;font-size: 40px;padding-top: 15px;}
      h5 {font-family:'Montserrat', sans-serif;font-size: 20px;padding-top: 15px;}
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

      var options = {'title':'Odhodki',
                    'is3D':true,
                     'width':600,
                     'height':500,
                     backgroundColor: '#FFFFFB'};

      // Instantiate and draw the chart.
      var chart = new google.visualization.PieChart(document.getElementById('myPieChartOdhodki'));
      chart.draw(data, options);
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

      var options = {'title':'Prihodki',
                    'is3D':true,
                     'width':600,
                     'height':500,
                     backgroundColor: '#FFFFFB'};

      // Instantiate and draw the chart.
      var chart = new google.visualization.PieChart(document.getElementById('myPieChartPrihodki'));
      chart.draw(data, options);
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
  </div>
    %else:
  
      <div id= "overlay" class="alert alert-success alert-dismissible fade show" align = "center" role="alert">
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
    %end


  <div align = "center">
    <table class="columns">
      <tr>
        <td><div id="myPieChartOdhodki"/></td>
        <td><div id="myPieChartPrihodki"/></td>
      </tr>
    </table>


    <table class="table table-sm" id="stroski">
      <h5><label for="stroski">Stroški</label></h5>
      <thead class="thead-light">
        <tr>
          <th scope="col">Kategorija</th>
          <th scope="col">Znesek (v EUR)</th>
          <th scope="col">Odstotek</th>
        </tr>
      </thead>
      <tbody>
        %for kategorija in slovar_zapravljeno.keys():
          <tr>
            <td>{{kategorija}}</td>
            <td>{{slovar_zapravljeno[kategorija]}}</td>
            <td>{{slovar_procentov_odhodek[kategorija]}} %</td>
          </tr>
        %end
        <tr>
          <td>Skupaj:</td>
          <td>{{skupaj_odhodki}}</td>
          <td>100 %</td>
        </tr>
      </tbody>
    </table>


    <table class="table table-sm" id = "prihodki">
      <h5><label for="prihodki">Prihodki</label></h5>
      <thead class="thead-light">
        <tr>
          <th scope="col">Kategorija</th>
          <th scope="col">Znesek (v EUR)</th>
          <th scope="col">Odstotek</th>
        </tr>
      </thead>
      <tbody>
        %for kategorija in slovar_zasluzeno.keys():
          <tr>
            <td>{{kategorija}}</td>
            <td>{{slovar_zasluzeno[kategorija]}}</td>
            <td>{{slovar_procentov_prihodek[kategorija]}} %</td>
          </tr>
        %end
        <tr>
          <td>Skupaj:</td>
          <td>{{skupaj_prihodki}}</td>
          <td>100 %</td>
        </tr>
      </tbody>
    </table>

  </div>
</div>

