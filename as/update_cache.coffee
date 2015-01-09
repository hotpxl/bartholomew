path = require 'path'
fs = require 'fs'
_ = require 'lodash'
split = require 'split'

rirList = ['afrinic', 'apnic', 'arin', 'lacnic', 'ripencc']

readRirDataIntoCache = (acc, rir) ->
  rawData = fs.readFileSync \
    path.join(__dirname, "./data/delegated-#{rir}-extended-latest"),
    encoding: 'utf-8'
  _.reduce rawData.trim().split('\n'), (acc, line) ->
    if line[0] != '#'  # Skip comments
      [registry, countryCode, type, start, value, date, status] = line.trim().split '|'
      if type == 'asn' && (status == 'allocated' || status == 'assigned')  # Skip header and non AS entries
        start = parseInt start
        value = parseInt value
        if countryCode?.length != 2 ||
        registry != rir ||
        start < 0 ||
        value < 1
          throw new Error('Cannot parse record file')
        for id in [start..start + value - 1]
          acc.push
            id: id
            countryCode: countryCode
            registry: registry
    acc
  , acc

if require.main == module
  cache = _.sortBy _.reduce(rirList, readRirDataIntoCache, []), 'id'
  fs.writeFileSync \
    path.join(__dirname, './data/cache.json'),
    JSON.stringify(cache),
    encoding: 'utf-8'
