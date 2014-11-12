express = require 'express'
path = require 'path'
mapOfAS = require '../map-of-as/process'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/api/as', (req, res, next) ->
  res.json mapOfAS.getNumASForCountries mapOfAS.parseFile(path.join(__dirname, '../map-of-as/as_raw.txt'))

module.exports = router

