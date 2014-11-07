google.load 'visualization', '1', packages: ['geochart']

drawRegionsMap = ->
  $.getJSON '/api/as', (data) ->
    data.unshift ['Country', 'Number of ASes']
    readyData = google.visualization.arrayToDataTable data
    chart = new google.visualization.GeoChart(document.getElementById('regions_div'))
    chart.draw readyData, {}

google.setOnLoadCallback drawRegionsMap
