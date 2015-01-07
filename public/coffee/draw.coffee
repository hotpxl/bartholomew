initialize = ->
  mapOptions =
    center:
      lat: -34.397
      lng: 150.644
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
      )
      new google.maps.Polyline(
        path: [
          v,
          { lat: 0, lng: 0 }
        ]
        geodesic: true
        strokeColor: '#FF0000'
        strokeOpacity: 1.0
        strokeWeight: 2
        map: map
      )

google.maps.event.addDomListener window, 'load', initialize

