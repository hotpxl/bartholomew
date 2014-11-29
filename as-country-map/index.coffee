_ = require 'lodash'
fs = require 'fs'
path = require 'path'

parseFile = (filename) ->
  raw = fs.readFileSync filename, encoding: 'utf-8'
  rawList = raw.trim().split '\n'
  asToCountry = {}
  _.forEach rawList, (i) ->
    name = i.split(' ', 1)[0][2..]
    if name
      country = do (i) ->
        split = i.split ','
        split[split.length - 1]
      if country
        asToCountry[name] = country
  asToCountry

exports.asToCountryMap = asToCountryMap = do ->
  parseFile path.join(__dirname, './as_raw.txt')

exports.getASListForCountry = getASListForCountry = (country) ->
  ret = []
  _.forEach asToCountryMap, (v, k) ->
    if v == country
      ret.push k
  ret

exports.getASListsForAllCountries = getASListsForAllCountries = ->
  ret = {}
  _.forEach asToCountryMap, (v, k) ->
    if not ret[v]
      ret[v] = []
    ret[v].push(k)
  ret

exports.getNumOfASesForAllCountries = getNumOfASesForAllCountries = ->
  countries = getASListsForAllCountries asToCountryMap
  _.map countries, (v, k) ->
    [k, v.length]

