{connect, db} = require './db'
rethinkdb = require 'rethinkdb'

connect (conn) ->
  rethinkdb.dbCreate('cubezapp').run conn, (err) ->
    throw err if err?
    db.tableCreate('accounts').run conn, (err) ->
      throw err if err?
      conn.close ->
        process.exit 0
