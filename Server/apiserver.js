// node.js modules
var http = require('http');
var url = require('url');

// my modules
var webapi = require('webapi');
var db = require('accountdata').db;

/**
 * Called for all requests to /api
 */
function handleAPICall(req, res) {
    var theBuff = new Buffer('');
    var contentType = req.headers['content-type'];
    
    var acceptedTypes = ['application/keyedbits', 'application/keyedbits64'];
    if (acceptedTypes.indexOf(contentType)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end('Invalid content type. Must provide KeyedBits data.');
        return;
    }
    
    req.on('data', function (data) {
        theBuff = Buffer.concat([theBuff, data]);
        if (theBuff.length > 1000000) { // a one megabyte API call? this is too big!
            req.connection.destroy();
        }
    });
    
    req.on('end', function () {
        // parse the data and hand it off
        webapi.respond(theBuff, contentType, res);
    });
}

/**
 * Creates the HTTP server *
 */
function serve(port) {
    http.createServer(function (req, res) {
        var parsed = url.parse(req.url, false);
        if (parsed.pathname == '/api') {
            // we have an API call and we shall handle it
            handleAPICall(req, res);
        } else {
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end('You are a loser');
        }
    }).listen(port, '');
    console.log('Created HTTP server on port ' + port);
}

db.conn.initializeDb(function (err) {
    if (err) {
        console.log('Failed to initialize database: ' + err.message);
        process.exit();
    } else {
        console.log('Successfully initialized database');
        serve(1234);
    }
});

