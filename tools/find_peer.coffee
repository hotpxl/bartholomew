fs = require 'fs'
readline = require 'readline'
lazy = require 'lazy'
_ = require 'underscore'

aggregateToArray = (str) ->
  cur = parseInt str
  if isNaN cur
    _.map str[1..-2].split(','), (i) -> parseInt(i)
  else
    [cur]

addPath = (from, to, d) ->
  # from and to should be numbers
  if from == to
    return
  if to < from
    [from, to] = [to, from]
  if not d[from]
    d[from] = [to]
  else
    d[from].push to

processSingleDumpFile = (dumpFilename, targetFilename, callback) ->
  target = _.map _.filter(fs.readFileSync(targetFilename, encoding: 'ascii').split('\n'), (i) -> i.length), (i) -> parseInt(i)
  connection = {}
  lazy fs.createReadStream dumpFilename, encoding: 'ascii'
    .lines
    .map(String)
    .map (str) ->
      # Skip non entries
      if str[0] != '*'
        return
      path = str.trim()[61..].split(/\s+/)[..-2]
      if path.length < 2
        return
      for i in [0..path.length - 2]
        from = aggregateToArray path[i]
        to = aggregateToArray path[i + 1]
        for j in from
          for k in to
            addPath j, k, connection
    .on 'pipe', ->
      for k, v of connection
        if parseInt k not in target
          delete connection[k]
        else
          connection[k] = _.filter _.uniq(v.sort((a, b) -> a - b), true), (num) ->
            num in target
          if not connection[k].length
            delete connection[k]
        callback(connection)

if require.main == module
  if process.argv.length != 4
    console.log 'Usage: ' + process.argv[0..1].join(' ') + ' filename AS'
    process.exit 1
  stream = fs.createReadStream process.argv[2], encoding: 'ascii'
  target = _.map _.filter(fs.readFileSync(process.argv[3], encoding: 'ascii').split('\n'), (i) -> i.length), (i) -> parseInt(i)
  dic = {}
  lazy stream
    .lines
    .map(String)
    .map (str) ->
      # Skip non entries
      if str[0] != '*'
        return
      path = str.trim()[61..].split(/\s+/)[..-2]
      if path.length < 2
        return
      for i in [0..path.length - 2]
        from = aggregateToArray path[i]
        to = aggregateToArray path[i + 1]
        for j in from
          for k in to
            addPath j, k, dic
    .on 'pipe', ->
      console.log 'IO done'
      for k, v of dic
        if parseInt k not in target
          delete dic[k]
        else
          dic[k] = _.filter _.uniq(v.sort((a, b) -> a - b), true), (num) ->
            num in target
          if not dic[k].length
            delete dic[k]
      console.log dic

