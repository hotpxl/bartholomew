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

if require.main == module
  fs.writeFileSync 'parsed.json', JSON.stringify(parseFile(path.join(__dirname, './as_raw.txt')))
