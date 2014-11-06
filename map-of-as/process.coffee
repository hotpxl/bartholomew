_ = require 'lodash'
fs = require 'fs'

parseFile = (filename) ->
  raw = fs.readFileSync filename, encoding: 'utf-8'
  rawList = raw.split '\n'
  asToCountry = {}
  _.map rawList, (i) ->
    name = i.split(' ', 1)[0][2..]
    if name
      country = do (i) ->
        split = i.split ','
        split[split.length - 1]
      asToCountry[name] = country
  asToCountry

getASForCountry = (asToCountry, country) ->
  ret = []
  _.map asToCountry, (v, k) ->
    if v == country
      ret.push k
  ret

exports.parseFile = parseFile
exports.getASForCountry = getASForCountry

a = parseFile 'as_raw.txt'
b = getASForCountry a, 'LY'
console.log b
