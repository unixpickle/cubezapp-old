function Handler(packet, contentType) {
    this.packet = packet;
    this.contentType = contentType;
}

Handler.prototype.handle = function(callback) {
    if (!this[this.packet.getAPIName()]) {
        return callback(new Error('Call not found on API handler'), null);
    }
    this[this.packet.getAPIName()](callback);
}

exports.Handler = Handler;
