path = require 'path'
fs = require 'fs'
should = require('chai').should()
m = require '../as-country-map/process'

describe 'AS of Country Map', ->
  describe '#parseFile()', ->
    it 'should correctly parse example file', ->
      m.parseFile path.join(__dirname, 'as-country-map-example.input')
      .should.deep.
      equal JSON.parse(fs.readFileSync(path.join(__dirname, 'as-country-map-example.expected')))
