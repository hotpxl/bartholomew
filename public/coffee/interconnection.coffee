L.mapbox.accessToken = 'pk.eyJ1Ijoia2V2aW5sZWVvbmUiLCJhIjoiWDRPNTMzNCJ9.JHKw2xWdaKBahnn7SxtI9g'
map = L.mapbox.map 'map', 'kevinleeone.kbc2l4an'

$.getJSON '/api/interconnection', (data) ->
  for i in data.connection
    from = i[0]
    to = i[1]
    L.polyline([data.loc[from], data.loc[to]],
      color: '#555'
      weight: 1
    ).addTo map

