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

exports.findWithId = findWithId = do ->
  reverseLookup = _.reduce cache, (acc, item) ->
    acc[item.id] = item
    acc
  , {}
  (id) ->
    _.cloneDeep reverseLookup[id]

