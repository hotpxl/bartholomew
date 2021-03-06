_ = require 'lodash'

cache = require './cache.json'

exports.findWithCountry = findWithCountry = (countryCode) ->
  _.cloneDeep cache[countryCode]

exports.getCountryLocations = getCountryLocations = do ->
  res = _.reduce cache, (acc, v, k) ->
    acc[k] = v.location
    acc
  , {}
  ->
    _.cloneDeep res

exports.getCandidates = getCandidates = do ->
  res = _.map cache, (v, k) ->
    k
  ->
    _.cloneDeep res

# exports.getConnectionsOfCountries = getConnectionsOfCountries = ->
#   asConnection = interConnectionOfAS.getConnection path.join(__dirname, '../interconnection-of-as/2014-11-07_0000_bgp')
#   buf = ([] for i in [1..reverseLookupForCountryID.length])
#   _.forEach asConnection, (list, from) ->
#     fromCountryID = reverseLookupForAS[from]
#     if fromCountryID?
#       _.forEach list, (to) ->
#         toCountryID = reverseLookupForAS[to]
#         if toCountryID?
#           buf[fromCountryID][toCountryID] = 1
#           buf[toCountryID][fromCountryID] = 1
#   ret = []
#   _.forEach buf, (list, from) ->
#     for i in [from + 1..list.length + 1]
#       if list[i]
#         ret.push [reverseLookupForCountryID[from], reverseLookupForCountryID[i]]
#   ret

