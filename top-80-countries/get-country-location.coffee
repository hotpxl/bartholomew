https = require 'https'
fs = require 'fs'
_ = require 'lodash'

key = 'AIzaSyBlsRw-KSzoIqP5mGZtJJo7WC2U55WvtmI'

baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address='

getJson = (url, cb) ->
  output = ''
  https.get url, (res) ->
    res.setEncoding 'utf-8'
    res.on 'data', (chunk) ->
      output += chunk
    res.on 'end', ->
      data = JSON.parse output
      console.log data.results
      cb data.results[0].geometry.location

countries = fs.readFileSync 'top_80_countries.txt', encoding: 'utf-8'
.trim().split('\n')

countryFullName = JSON.parse fs.readFileSync('slim-2.json', encoding: 'utf-8')

countryLocations = {}

for i in countries
  fullName = _.find countryFullName, (chr) ->
    chr['alpha-2'] == i
  countryLocations[i] = fullName: fullName?.name

getLocation = (i) ->
  if i < countries.length
    name = countries[i]
    country = countryLocations[name]
    url = "#{baseUrl}#{country.fullName}&key=#{key}"
    getJson url, (res) ->
      country.location = res
      getLocation i + 1
  else
    fs.writeFileSync 'output.json', JSON.stringify(countryLocations)

getLocation 0
