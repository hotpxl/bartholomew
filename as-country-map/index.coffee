_ = require 'lodash'
fs = require 'fs'
path = require 'path'
parsed = require './parsed.json'

exports.asToCountryMap = parsed

exports.getASListForCountry = getASListForCountry = (country) ->
  ret = []
  _.forEach parsed, (v, k) ->
    if v == country
      ret.push k
  ret

exports.getASListsForAllCountries = getASListsForAllCountries = ->
  ret = {}
  _.forEach parsed, (v, k) ->
    if not ret[v]
      ret[v] = []
    ret[v].push(k)
  ret

exports.getNumOfASesForAllCountries = getNumOfASesForAllCountries = ->
  countries = getASListsForAllCountries parsed
  _.map countries, (v, k) ->
    [k, v.length]

