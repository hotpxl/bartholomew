path = require 'path'
fs = require 'fs'
should = require('chai').should()
supertest = require 'supertest'
m = require '../as-country-map/process'
app = require '../app'
app.enable 'automatedTesting'

describe 'AS of Country Map', ->
  parsed = m.parseFile path.join(__dirname, 'as-names.input')
  describe '#parseFile()', ->
    it 'should correctly parse AS names file', ->
      parsed.should.deep
      .equal JSON.parse(fs.readFileSync(path.join(__dirname, 'as-names.expected')))
  describe '#getASForCountry()', ->
    it 'should count correctly for China', ->
      m.getASForCountry(parsed, 'CN').should.have.length 745
    it 'should find the AS for Netherlands Antilles', ->
      m.getASForCountry(parsed, 'AN').should.deep.equal ['61473']

describe 'Server', ->
  describe 'user page', ->
    it 'should return 200', (done) ->
      supertest(app).get('/').expect 200, done
  describe 'API', ->
    it 'should return JSON', (done) ->
      supertest(app).get '/api/as'
      .expect 200
      .expect 'Content-Type', /json/
      .expect (res) ->
        res.body
        .should.deep
        .equal JSON.parse fs.readFileSync(path.join(__dirname, 'as-country-map-json.expected'))
        return
      .end (err) ->
        done(err)
