path = require 'path'
fs = require 'fs'
asCountryMap = require '../as-country-map'
_ = require 'lodash'

countryListWithASes = do ->
  location = JSON.parse fs.readFileSync('output.json', encoding: 'utf-8')
  _.forEach location, (v, k) ->
    v.asList = asCountryMap.getASListForCountry k
  location

exports.getLocationFromAS = getLocationFromAS = (as) ->
  countryListWithASes[asCountryMap.asToCountryMap[as]]?.location

