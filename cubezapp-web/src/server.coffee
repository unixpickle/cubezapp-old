if process.argv.length isnt 3
  console.error 'Usage: coffee server.coffee <port>'
  process.exit 1

express = require 'express'
session = require 'express-session'
app = express()

app.disable 'etag'

app.use session
  secret: 'aoeuaoeuaoeu'
  resave: false
  saveUninitialized: true

app.use require './middleware/cache'
app.use require './middleware/mobile'
app.use require './middleware/mustache'

app.get '/view_desktop', (req, res) ->
  req.session.site = 'desktop'
  res.redirect '.'

app.get '/view_mobile', (req, res) ->
  req.session.site = 'mobile'
  res.redirect '.'

app.get '/', (req, res) -> res.sendTemplate 'home'

app.listen parseInt process.argv[2]
