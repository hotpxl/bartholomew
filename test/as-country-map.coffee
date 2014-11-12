path = require 'path'
fs = require 'fs'
should = require('chai').should()
m = require '../as-country-map/process'

describe 'AS of Country Map', ->
  parsed = m.parseFile path.join(__dirname, 'as-country-map-example.input')
  describe '#parseFile()', ->
    it 'should correctly parse example file', ->
      parsed.should.deep.
      equal JSON.parse(fs.readFileSync(path.join(__dirname, 'as-country-map-example.expected')))
  describe '#getASForCountry()', ->
    it 'should count correctly for China', ->
      m.getASForCountry(parsed, 'CN').should.have.length 745
    it 'should find the AS for Netherlands Antilles', ->
      m.getASForCountry(parsed, 'AN').should.deep.equal ['61473']

