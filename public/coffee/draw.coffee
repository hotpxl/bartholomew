google.load 'visualization', '1', packages: ['geochart']

drawRegionsMap = ->
  data = google.visualization.arrayToDataTable [
    ['Country', 'Popularity'],
    ['Germany', 200],
    ['United States', 300],
    ['Brazil', 400],
    ['Canada', 500],
    ['France', 600],
    ['RU', 700]
  ]
  chart = new google.visualization.GeoChart(document.getElementById('regions_div'))
  chart.draw data, {}
  return

google.setOnLoadCallback drawRegionsMap
