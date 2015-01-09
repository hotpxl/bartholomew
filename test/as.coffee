path = require 'path'
fs = require 'fs'
should = require('chai').should()
_ = require
m = require '../as'

describe 'AS', ->
  describe '#findWithCountry', ->
    it 'should find the AS for Netherlands Antilles', ->
      m.findWithCountry('AN').should.deep.equal [61473]

