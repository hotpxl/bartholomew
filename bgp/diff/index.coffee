_ = require 'lodash'

diffList = (from, to) ->
  # Input lists should be sorted
  fromIndex = 0
  toIndex = 0
  res = []
  while fromIndex < from.length and toIndex < to.length
    if from[fromIndex] < to[toIndex]
      res.push -from[fromIndex]
      fromIndex++
    else if to[toIndex] < from[fromIndex]
      res.push to[toIndex]
      toIndex++
    else
      fromIndex++
      toIndex++
  res

exports.diff = diff = (from, to) ->
  acc = _.reduce from, (acc, path, conn) ->
    if conn not of to
      acc[conn] = _.map path, (i) -> -i
    else
      d = diffList path, to[conn]
      if d.length
        acc[conn] = diffList path, to[conn]
    acc
  , {}
  _.reduce to, (acc, path, conn) ->
    if conn not of from
      acc[conn] = path
    acc
  , acc

if require.main == module
  p1 = '../data/2014-11-07_0000_bgp'
  p2 = '../data/2015-01-06_0000_bgp'
  a = require '../connection'
  console.log diff(a.parse(p1), a.parse(p2))
