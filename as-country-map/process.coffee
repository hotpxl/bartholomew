_ = require 'lodash'
fs = require 'fs'

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

getASForCountry = (asToCountry, country) ->
  ret = []
  _.forEach asToCountry, (v, k) ->
    if v == country
      ret.push k
  ret

getASForCountries = (asToCountry) ->
  ret = {}
  _.forEach asToCountry, (v, k) ->
    if not ret[v]
      ret[v] = []
    ret[v].push(k)
  ret

getNumASForCountries = (asToCountry) ->
  countries = getASForCountries asToCountry
  _.map countries, (v, k) ->
    [k, v.length]

exports.parseFile = parseFile
exports.getASForCountry = getASForCountry
exports.getASForCountries = getASForCountries
exports.getNumASForCountries = getNumASForCountries

