The `webapi` module makes it easy to serve an API response.

# Methods

`webapi.respond(buffer, contentType, res)` handles a request and returns the data in the appropriate content type.

* *buffer* - a Buffer object (raw uploaded data)
* *contentType* - a string containing either 'application/keyedbits' or 'application/keyedbits64'
* *res* - a node.js HTTP response object

# Developer Documentation

In order to create a new API handler, simply create a subclass of `handlers/base.js` with the necessary methods for each API call.

The `isUnauthenticated()` method should return `true` for all API methods which *require* authorization. For authenticated requests, `this.account` will be set when the corresponding method is called on a handler. If authentication fails, the API method is never called.