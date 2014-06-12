fs = require 'fs'
readline = require 'readline'
lazy = require 'lazy'
_ = require 'underscore'

aggregateToArray = (str) ->
  str[1..-2].split ','

addPath = (from, to, d) ->
  if from == to
    return
  if not d[from]
    d[from] = [to]
  else
    d[from].push to

if require.main == module
  if process.argv.length != 3
    console.log 'Usage: ' + process.argv[0..2].join(' ') + ' filename'
    process.exit 1
  stream = fs.createReadStream process.argv[2], encoding: 'ascii'
  target = (i for i in [1..10000])
  dic = {}
  lazy stream
    .lines
    .map(String)
    .skip 5
    .map (str) ->
      if str[0] != '*'
        return
      path = str.split(/\s+/)[4..-2]
      if path.length < 2
        return
      for i in [0..path.length - 2]
        cur = parseInt path[i]
        from = if isNaN cur then aggregateToArray path[i] else [cur]
        next = parseInt path[i + 1]
        to = if isNaN next then aggregateToArray path[i + 1] else [next]
        for j in from
          for k in to
            addPath j, k, dic
    .on 'pipe', ->
      console.log 'IO done'
      for k, v of dic
        dic[k] = _.uniq(v)
      console.log dic

