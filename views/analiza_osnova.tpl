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

      // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Draw the pie chart for Odhodki when Charts is loaded.
      google.charts.setOnLoadCallback(DrawOdhodki);

      // Draw the pie chart for the Prihodki when Charts is loaded.
      google.charts.setOnLoadCallback(DrawPrihodki);

      // Callback that draws the pie chart for Odhodki
      function DrawOdhodki() {

        // Create the data table for Odhodki.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Kategorija');
        data.addColumn('number', 'Odstotki');
         %for kategorija in slovar_zapravljeno.keys():
      data.addRows([
        ['{{kategorija}}', {{slovar_zapravljeno[kategorija]}}],
      ]);
      %end

        // Set options for pie chart.
        var options = {title:'Odhodki za obdobje {{mesec}} {{leto}},
                       width:400,
                       height:300};

        // Instantiate and draw the chart.
        var chart = new google.visualization.PieChart(document.getElementById('Odhodki_div'));
        chart.draw(data, options);
      }

      // Callback that draws the pie chart for Prihodki.
      function drawPrihodki() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Kategorija');
        data.addColumn('number', 'Odstotki');
        %for kategorija in slovar_zasluzeno.keys():
      data.addRows([
        ['{{kategorija}}', {{slovar_zasluzeno[kategorija]}}],
      ]);
      %end
        

        // Set options:
        var options = {title:'Prihodki za obdobje {{mesec}} {{leto}',
                       width:400,
                       height:300};

        // Instantiate and draw the chart.
        var chart = new google.visualization.PieChart(document.getElementById('Prihodki_div'));
        chart.draw(data, options);
      }
    </script>


</head>

<body>
  {{ !base }}
</body>