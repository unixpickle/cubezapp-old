mustache = require 'mustache'
fs = require 'fs'

module.exports = (req, res, next) ->
  if not req.site?
    throw new Error 'mustache middleware requires mobile middleware'
  site = req.session.site ? req.site
  res.sendTemplate = (name, object = {}) ->
    filePath = __dirname + "/../../pages/#{site}/#{name}.mustache"
    object.siteOverride = req.session.site?
    fs.readFile filePath, {encoding: 'utf8'}, (err, data) ->
      return res.send 500, 'Failed to read template ' + name if err?
      res.send 200, mustache.render data, object
  next()
