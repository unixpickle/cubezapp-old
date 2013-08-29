var http = require('http');
var url = require('url');

function handleAPICall(req, res) {
    var theBuff = new Buffer('');
    
    var acceptedTypes = ['application/keyedbits', 'application/keyedbits-64'];
    if (acceptedTypes.indexOf(req.headers['content-type'])) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end('Invalid content type. Must provide KeyedBits data.');
        return;
    }
    
    req.on('data', function (data) {
        theBuff = Buffer.concat([theBuff, data]);
        if (theBuff.length > 1000000) {
            // a one megabyte API call? this is too big!
            req.connection.destroy();
        }
    });
    req.on('end', function () {
        // parse the data and hand it off
        if (req.headers['content-type'] == 'application/keyedbits') {
            // it is raw keyedbits data
        } else {
            // it is base64 encoded keyedbits data
        }
    });
}

http.createServer(function (req, res) {
    var parsed = url.parse(req.url, false);
    if (parsed.pathname == '/api') {
        // we have an API call and we shall handle it
        handleAPICall(req, res);
    } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('You are a loser');
    }
}).listen(1234, '127.0.0.1');
