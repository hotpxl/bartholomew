fs = require 'fs'
path = require 'path'
_ = require 'lodash'
debug = require('debug')('bgp:connection')

exports.parse = parse = (filename) ->
  debug "parse #{filename}"
  addPath = (from, to, d) ->
    # from and to should be different numbers
    if from != to
      if to < from
        [from, to] = [to, from]
      if not d[from]?
        d[from] = []
      d[from].push to
    d
  aggregateToArray = (str) ->
    cur = parseInt str
    if isNaN cur
      _.map str[1..-2].split(','), (i) ->
        parseInt i
    else
      [cur]
  rawEntries = fs.readFileSync(filename, encoding: 'UTF-8').trim().split '\n'
  validEntries = _.filter rawEntries, (str) ->
    str[0] == '*'
  connection = _.reduce validEntries, (accumulator, str) ->
    asPath = str.trim().split(/\s+/)[4..-2]
    if 2 <= asPath.length
      from = aggregateToArray asPath[0]
      for i in [1..asPath.length - 1]
        to = aggregateToArray asPath[i]
        for j in from
          for k in to
            addPath j, k, accumulator
        from = to
    accumulator
  , {}
  _.forEach connection, (v, k) ->
    connection[k] = _.uniq _.sortBy(v), true

exports.getByDate = getByDate = (date) ->
  filename = "../data/#{date.toISOString()[..9]}_0000_bgp"
  p = path.join __dirname, filename
  if not fs.existsSync p
    new Error('File does not exist')
  else
    parse p

