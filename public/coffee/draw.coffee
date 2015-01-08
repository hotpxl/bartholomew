initialize = ->
  mapOptions =
    center:
      lat: 52.13
      lng: 5.29
    zoom: 3
    zoomControl: false
    scrollwheel: false
    disableDoubleClickZoom: true
    streetViewControl: false
  map = new google.maps.Map($('#map-canvas')[0], mapOptions)
  $.get '/api/country/locations', (data) ->
    for k, v of data
      new google.maps.Marker(
        position: v
        map: map
        title: k
        animation: google.maps.Animation.DROP
      )
    $.get '/api/demo2', (connData) ->
      for k0, v0 of data
        for k1, v1 of data
          if k0 == k1
            continue
          if connData[k0][k1]
            new google.maps.Polyline(
              path: [v0, v1]
              geodesic: true
              strokeColor: '#FF0000'
              strokeOpacity: 0.5
              strokeWeight: connData[k0][k1] / 100
              map: map
            )

google.maps.event.addDomListener window, 'load', initialize

