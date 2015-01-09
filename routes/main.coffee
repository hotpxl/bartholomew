express = require 'express'
path = require 'path'
country = require '../country'
combinator = require '../combinator'
bgpConnection = require '../bgp/connection'
bgpDiff = require '../bgp/diff'

router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/angular', (req, res, next) ->
  res.render 'angular'

router.get '/partials/:p', (req, res, next) ->
  console.log req.param
  res.render req.params['p']

router.get '/api/country/locations', (req, res, next) ->
  res.json country.getCountryLocations()

router.get '/api/demo', (req, res, next) ->
  res.json combinator.getCountryConnections(bgpConnection.getByDate(new Date('2015-01-06')))

router.get '/api/demo2', (req, res, next) ->
  res.json combinator.getCountryDiffs(bgpDiff.getByDate(new Date('2014-11-07'), new Date('2015-01-06')))

module.exports = router

