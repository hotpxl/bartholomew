path = require 'path'
fs = require 'fs'
should = require('chai').should()
m = require '../bgp/connection'

describe 'Interconnection', ->
  connection = m.parse path.join(__dirname, 'bgp-dump.input')
  describe '#parse', ->
    it 'should handle all corner cases for dump files', ->
      connection.should.deep
      .equal JSON.parse(fs.readFileSync(path.join(__dirname, 'bgp-dump.expected')))
