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
  describe '#getASForCountry()', ->
    it 'should count correctly for China', ->
      parsed = m.parseFile path.join(__dirname, 'as-country-map-example.input')
      m.getASForCountry(parsed, 'CN').should.have.length 745
    it 'should find the AS for Netherlands Antilles', ->
      parsed = m.parseFile path.join(__dirname, 'as-country-map-example.input')
      m.getASForCountry(parsed, 'AN').should.deep.equal ['61473']

