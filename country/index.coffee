path = require 'path'
fs = require 'fs'
_ = require 'lodash'
asCountryMap = require '../as-country-map'
interConnectionOfAS = require '../interconnection-of-as'

countryListWithASes = do ->
  allCountries = asCountryMap.getASListsForAllCountries()
  location = JSON.parse fs.readFileSync(path.join(__dirname, 'parsed.json'), encoding: 'utf-8')
  _.forEach location, (v, k) ->
    v.asList = allCountries[k]
  location

reverseLookupForCountryID = do ->
  ret = _.map countryListWithASes, (v, k) ->
    k
  _.forEach ret, (v, i) ->
    countryListWithASes[v].id = i
  ret

reverseLookupForAS = do ->
  ret = {}
  _.forEach reverseLookupForCountryID, (name, i) ->
    _.forEach countryListWithASes[name].asList, (as) ->
      ret[as] = i
  ret

exports.getLocationFromAS = getLocationFromAS = (as) ->
  countryListWithASes[asCountryMap.asToCountryMap[as]]?.location

exports.getConnectionsOfCountries = getConnectionsOfCountries = ->
  asConnection = interConnectionOfAS.getConnection path.join(__dirname, '../interconnection-of-as/2014-11-07_0000_bgp')
  buf = ([] for i in [1..reverseLookupForCountryID.length])
  _.forEach asConnection, (list, from) ->
    fromCountryID = reverseLookupForAS[from]
    if fromCountryID?
      _.forEach list, (to) ->
        toCountryID = reverseLookupForAS[to]
        if toCountryID?
          buf[fromCountryID][toCountryID] = 1
          buf[toCountryID][fromCountryID] = 1
  ret = []
  _.forEach buf, (list, from) ->
    for i in [from + 1..list.length + 1]
      if list[i]
        ret.push [reverseLookupForCountryID[from], reverseLookupForCountryID[i]]
  ret

exports.getCountryLocations = getCountryLocations = ->
  ret = {}
  _.forEach countryListWithASes, (info, name) ->
    ret[name] = info.location
  ret

