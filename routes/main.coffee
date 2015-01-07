express = require 'express'
path = require 'path'
country = require '../country'

router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/api/country/locations', (req, res, next) ->
  res.json country.getCountryLocations()

module.exports = router

