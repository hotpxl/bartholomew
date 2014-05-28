express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
stylus = require 'stylus'
debug = require('debug')('bartholomew')

routes = require './routes/index'

app = express()

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use favicon(path.join(__dirname, 'public/images/favicon.ico'))
app.use logger()
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use '/static', stylus.middleware(path.join(__dirname, 'public/stylesheets'))
app.use '/static', express.static(path.join(__dirname, 'public'))

app.use '/', routes

app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: err

app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error',
    message: err.message
    error: {}

app.set 'port', process.env.PORT || 3000
server = app.listen app.get('port'), ->
  debug 'Express server listening on port ' + server.address().port

