path = require 'path'
fs = require 'fs'
should = require('chai').should()
_ = require
m = require '../as-country-map'

describe 'AS of Country Map', ->
  describe '#getASListForCountry()', ->
    it 'should find the AS for Netherlands Antilles', ->
      m.getASListForCountry('AN').should.deep.equal ['61473']
  describe '#getNumOfASesForAllCountries()', ->
    it 'should have the correct number of countries', ->
      m.getNumOfASesForAllCountries().should.have.length 235

