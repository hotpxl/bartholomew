express = require 'express'
path = require 'path'
mapOfAS = require '../as-country-map/process'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/api/as', (req, res, next) ->
  res.json mapOfAS.getNumASForCountries mapOfAS.parseFile(path.join(__dirname, '../as-country-map/as_raw.txt'))

module.exports = router

