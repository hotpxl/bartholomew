_ = require 'lodash'
mongoose = require 'mongoose'
debug = require('debug') 'asInfo'
secret = require './secret.json'
Info = require './model'

db = mongoose.connect secret.url

mongoose.connection.on 'disconnected', ->
  debug 'Mongoose default connection disconnected'

process.on 'SIGINT', ->
  db.disconnect()

exports.getASListForCountry = getASListForCountry = (country) ->
  ret = []
  _.forEach parsed, (v, k) ->
    if v == country
      ret.push k
  ret

exports.getASListsForAllCountries = getASListsForAllCountries = ->
  ret = {}
  _.forEach parsed, (v, k) ->
    if not ret[v]
      ret[v] = []
    ret[v].push(k)
  ret

exports.getNumOfASesForAllCountries = getNumOfASesForAllCountries = ->
  countries = getASListsForAllCountries parsed
  _.map countries, (v, k) ->
    [k, v.length]

Info.aggregate $group: {_id: '$countryCode', asList: {$push: '$id'}}, (err, res) ->
  console.log res

