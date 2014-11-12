express = require 'express'
path = require 'path'
mapOfAS = require '../as-country-map/process'
interconnectionOfAS = require '../interconnection-of-as/find_peer.coffee'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render 'index'

router.get '/2', (req, res, next) ->
  res.render 'interconnection'

router.get '/api/as', (req, res, next) ->
  res.json mapOfAS.getNumASForCountries mapOfAS.parseFile(path.join(__dirname, '../as-country-map/as_raw.txt'))

router.get '/api/interconnection', (req, res, next) ->
  targets = [4847, 4809, 4134, 10026, 6936]
  demo = interconnectionOfAS.pruneConnection interconnectionOfAS.getConnection(path.join(__dirname, '../as-country-map/2014-11-07_0000_bgp')), targets
  ret = {}
  ret.series = [
    type: 'force'
    itemStyle:
      normal:
        label:
          show: true
          textStyle:
            color: '#333'
        nodeStyle:
          brushType: 'both'
          borderColor: 'rgba(255,215,0,0.4)'
          borderWidth: 1
        lineStyle:
          type: 'curve'
    nodes: []
    links: []
  ]
  for i in targets
    ret.series[0].nodes.push
      name: i.toString()
  for k, vs of demo
    for v in vs
      ret.series[0].links.push
        source: k
        target: v.toString()
  res.json ret

module.exports = router

