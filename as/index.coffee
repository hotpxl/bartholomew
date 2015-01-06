_ = require 'lodash'
debug = require('debug') 'asInfo'

cache = require './data/cache.json'

exports.findWithCountry = findWithCountry = do ->
  asListOfCountry =
    _.reduce cache, (acc, item) ->
      if not acc[item.countryCode]?
        acc[item.countryCode] = []
      acc[item.countryCode].push item.id
      acc
    , {}
  (countryCode) ->
    asListOfCountry[countryCode]

exports.findWithID = findWithID = (id) ->
  _.find cache, (i) ->
    i.id == id

