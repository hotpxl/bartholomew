fs = require 'fs'
readline = require 'readline'
_ = require 'lodash'

addPath = (from, to, d) ->
  # from and to should be numbers
  if from != to
    if to < from
      [from, to] = [to, from]
    if not d[from]
      d[from] = [to]
    else
      d[from].push to
  d

exports.getConnection = (filename) ->
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
      for i in [1..path.length - i]
        to = aggregateToArray path[i]
        for j in from
          for k in to
            addPath j, k, accumulator
        from = to
    accumulator
  , {}
  _.forEach connection, (v, k) ->
    connection[k] = _.uniq _.sortBy(v), true

exports.pruneConnection = (connection, targets) ->
  _.reduce connection, (accumulator, v, k) ->
    if parseInt(k) in targets
      pruned =  _.filter v, (i) ->
        i in targets
      if pruned.length
        accumulator[k] = pruned
    accumulator
  , {}

