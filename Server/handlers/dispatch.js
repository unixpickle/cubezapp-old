var keyedbits = require('keyedbits');
var accountdata = require('accountdata');
var fs = require('fs');
var path = require('path');

function sendPacket(status, dictionary, contentType, response) {
    var buffer = new keyedbits.buffer();
    var encoder = new keyedbits.encode(buffer);
    if (!encoder.encode(dictionary)) return null;
    var theData = null;
    if (contentType == 'application/keyedbits') {
        theData = new Buffer(buffer.array);
    } else {
        theData = keyedbits.base64.encode(buffer);
    }
    response.writeHead(status, {'Content-Type': contentType,
                                'Content-Length': theData.length});
    response.end(theData);
}

function decodePacket(aBuffer, contentType) {
    // decode possible HTTP encoding
    var buffer = null;
    if (contentType == 'application/keyedbits64') {
        buffer = keyedbits.base64.decode(aBuffer.toString());
    } else {
        buffer = accountdata.db.convert.convertData(aBuffer, 'KBBuffer');
    }
    if (!buffer) return null;

    // decode keyedbits data
    var decoded = null;
    try {
        var decoder = new keyedbits.decode(buffer);
        decoded = decoder.decode();
    } catch (e) {
        console.log('keyedbits exception: ' + e);
        return null;
    }
    if (!decoded) return null;
    if (typeof decoded != 'object') return null;
    
    // decode packet
    if (!decoded['call'] || !decoded['object']) {
        return null;
    }
    if (typeof decoded['call'] != 'string' ||
        typeof decoded['object'] != 'object') {
        return null;
    }

    // decode API object
    var ClientPacket = accountdata.packet.ClientPacket;
    var packet = new ClientPacket(decoded['call'], decoded['object']);
    if (!packet.validate()) return null;
    
    return packet;
};

exports.dispatchHandler = function(buffer, contentType, response) {
    var packet = decodePacket(buffer, contentType);
    if (!packet) {
        return sendPacket(400, {'error': 'Failed to parse packet'}, contentType, response);
    }
    var fileName = path.resolve(__dirname, packet.getAPIDomain() + '.js');
    fs.exists(fileName, function (exists) {
        if (!exists) {
            return sendPacket(400, {'error': 'API Not found'}, contentType, response);
        }
        var aModule = require('./' + packet.getAPIDomain() + '.js');
        if (!aModule || !aModule.handler) {
            return sendPacket(400, {'error': 'API failed to load'}, contentType, response);
        }
        var handler = new aModule.handler(packet, contentType);
        handler.handle(function (err, dictionary) {
            if (err) {
                sendPacket(400, {'error': err.message}, contentType, response);
            } else {
                sendPacket(200, dictionary, contentType, response);
            }
        });
    });
}
