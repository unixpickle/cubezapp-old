var handler = require('./handler.js');

function Account(aBuffer, contentType) {
    handler.Handler.call(this, aBuffer, contentType);
}

Account.prototype = Object.create(handler.Handler.prototype);

Account.prototype.setValues = function(callback) {
    callback(new Error('NYI'), null);
}

Account.prototype.getAccount = function(callback) {
    callback(new Error('NYI'), null);
}

Account.prototype.signin = function(callback) {
    callback(new Error('NYI'), null);
}

exports.handler = Account;
