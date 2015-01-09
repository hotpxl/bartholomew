_ = require 'lodash'
country = require '../country'
bgpConnection = require '../bgp/connection'
as = require '../as'

exports.getCountryConnections = getCountryConnections = (parsedTable) ->
  candidates = country.getCandidates()
  connTable = do ->
    _.reduce candidates, (acc, country) ->
      acc[country] = _.reduce candidates, (acc, country) ->
        acc[country] = 0
        acc
      , {}
      acc
    , {}
  _.reduce parsedTable, (connTable, connections, endPoint) ->
    endPoint = parseInt endPoint
    fromCountry = as.findWithId(endPoint)?.countryCode
    if fromCountry in candidates
      _.reduce connections, (connTable, connection) ->
        toCountry = as.findWithId(connection)?.countryCode
        if toCountry in candidates
          connTable[fromCountry][toCountry] += 1
          connTable[toCountry][fromCountry] += 1
        connTable
      , connTable
    else
      connTable
  , connTable

exports.getCountryDiffs = getCountryDiffs = (diffTable) ->
  candidates = country.getCandidates()
  connTable = do ->
    _.reduce candidates, (acc, country) ->
      acc[country] = _.reduce candidates, (acc, country) ->
        acc[country] = 0
        acc
      , {}
      acc
    , {}
  _.reduce diffTable, (connTable, connections, endPoint) ->
    endPoint = parseInt endPoint
    fromCountry = as.findWithId(endPoint)?.countryCode
    if fromCountry in candidates
      _.reduce connections, (connTable, connection) ->
        absolute = Math.abs(connection)
        toCountry = as.findWithId(absolute)?.countryCode
        if toCountry in candidates
          sign = if absolute < 0 then -1 else 1
          connTable[fromCountry][toCountry] += sign
          connTable[toCountry][fromCountry] += sign
        connTable
      , connTable
    else
      connTable
  , connTable

if module == require.main
  a = require '../bgp/diff'
  console.log getCountryDiffs(a.getByDate(new Date('2014-11-07'), new Date('2015-01-06')))
