myChart = echarts.init document.getElementById('regions_div')
$.getJSON '/api/interconnection', (option) ->
  myChart.setOption option