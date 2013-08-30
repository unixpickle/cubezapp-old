var accountdata = require('accountdata');
var keyedbits = require('keyedbits');

exports.processPacket = function(buffer, contentType) {
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
        var decoder = new keyedbits.decode.KBDecode(buffer);
        decoded = decoder.decode();
    } catch (e) {
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
