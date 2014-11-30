express = require 'express'
path = require 'path'
# mapOfAS = require '../as-country-map/process'
top80Countries = require '../top-80-countries'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/2', (req, res, next) ->
  res.render 'interconnection'

# router.get '/api/as', (req, res, next) ->
#   res.json mapOfAS.getNumASForCountries mapOfAS.parseFile(path.join(__dirname, '../as-country-map/as_raw.txt'))

router.get '/api/interconnection', (req, res, next) ->
  ret = {}
  ret.connection = top80Countries.getConnectionsOfCountries()
  ret.loc = top80Countries.getCountryLocations()
  res.json ret

module.exports = router

