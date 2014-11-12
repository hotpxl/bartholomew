path = require 'path'
fs = require 'fs'
should = require('chai').should()
m = require '../interconnection-of-as/find_peer'

describe 'Interconnection', ->
  connection = m.getConnection path.join(__dirname, 'bgp-dump.input')
  describe '#getConnection()', ->
    it 'should handle all corner cases for dump files', ->
      connection.should.deep
      .equal JSON.parse(fs.readFileSync(path.join(__dirname, 'bgp-dump-full.expected')))
  describe '#pruneConnection()', ->
    it 'should be able to prune', ->
      m.pruneConnection connection, [999, 3549, 10026, 12715, 51487]
      .should.deep
      .equal JSON.parse(fs.readFileSync(path.join(__dirname, 'bgp-dump-prune.expected')))
    it 'should be able to prune without blanks', ->
      for k, v of m.pruneConnection connection, [4847, 4809, 4134, 10026, 6936]
        v.length.should.not.equal 0
