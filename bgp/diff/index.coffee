_ = require 'lodash'
bgpConnection = require '../connection'

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

exports.getByDate = getByDate = (dateFrom, dateTo) ->
  parseFrom = bgpConnection.getByDate dateFrom
  parseTo = bgpConnection.getByDate dateTo
  if parseFrom instanceof Error
    parseFrom
  else if parseTo instanceof Error
    parseTo
  else
    diff parseFrom, parseTo

