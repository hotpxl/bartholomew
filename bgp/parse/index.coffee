fs = require 'fs'
_ = require 'lodash'

exports.parse = parse = (filename) ->
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
    path = str.trim().split(/\s+/)[4..-2]
    if 2 <= path.length
      from = aggregateToArray path[0]
      for i in [1..path.length - 1]
        to = aggregateToArray path[i]
        for j in from
          for k in to
            addPath j, k, accumulator
        from = to
    accumulator
  , {}
  _.forEach connection, (v, k) ->
    connection[k] = _.uniq _.sortBy(v), true

