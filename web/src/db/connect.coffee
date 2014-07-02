rethinkdb = require 'rethinkdb'

connection = null
connecting = false
callbacks = []

module.exports = (cb) ->
  if connection?
    return cb connection
  callbacks.push cb
  return if connecting
  rethinkdb.connect '127.0.0.1', (err, conn) ->
    throw err if err?
    connection = conn
    for cb in callbacks
      cb connection
    callbacks = []
