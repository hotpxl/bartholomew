express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
morgan = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
stylus = require 'stylus'
connectCoffeeScript = require 'connect-coffee-script'

routes = require './routes/main'

# Setting
app = express()
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

# Middleware
app.use favicon(path.join(__dirname, '/public/images/favicon.ico'))
app.use morgan('dev',
  skip: ->
    return app.enabled 'automatedTesting'
)
app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }
app.use cookieParser()

# Dynamic routing
app.use '/', routes

# Static routing
app.use '/static/stylesheets', stylus.middleware(
  src: path.join __dirname, 'public/stylus'
  dest: path.join __dirname, 'public/stylesheets'
)
app.use '/static/javascripts', connectCoffeeScript(
  src: path.join __dirname, 'public/coffee'
  dest: path.join __dirname, 'public/javascripts'
)

app.use '/static', express.static(path.join(__dirname, 'public'))

# Error handling
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err

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

module.exports = app

