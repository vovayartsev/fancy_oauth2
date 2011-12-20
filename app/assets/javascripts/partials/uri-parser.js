/**
 * =================================================================
 * URI Parser
 * =================================================================
 * -----------------------------------------------------------------
 * Simple JavaScript object for editing and constructing URIs for
 * use in HREF's and such.
 * -----------------------------------------------------------------
 *
 * Written by Timothy Christensen
 * Version: 8-16-10
 *
 **/

var __UriParser = {
  
  // The ordering of this is array is relative to the names of the groups captured by __uriPartsRE.
  __uriParts: ['source', 'protocol', 'authority', 'domain', 'port', 'path', 'directoryPath', 'fileName', 'query', 'anchor'],
  
  // Match any URI and return groups which map to properties listed in the __uriParts arrays.
  __uriPartsRE: new RegExp("^(?:([^:/?#.]+):)?(?://)?(([^:/?#]*)(?::(\\d*))?)?((/(?:[^?#](?![^?#/]*\\.[^?#/.]+(?:[\\?#]|$)))*/?)?([^?#/]*))?(?:\\?([^#]*))?(?:#(.*))?"),
  
  // Matches the given URI string to its relevant parts and returns a new Uri object.
  parseUri: function(string) {
    var uri = {};
    var uriMatches = this.__uriPartsRE.exec(string);
    for (var i = 0; i < 10; i++) { uri[this.__uriParts[i]] = (uriMatches[i] ? uriMatches[i] : ''); }
    return new this.Uri(uri['protocol'], uri['domain'], uri['port'], uri['path'], uri['fileName'], uri['query'], uri['anchor']);
  },
  
  // Uri object which holds the values of the parsed URI.
  Uri: function(protocol, domain, port, path, fileName, query, anchor) {
    this.protocol = protocol;
    this.domain = domain;
    this.port = port;
    this.path = path;
    this.fileName = fileName;
    this.query = {};
    this.anchor = anchor;
    if (query.length) {  
      var param, params = query.split('&');
      for (i in params) {
        param = params[i].split('=');
        this.query[param[0]] = param[1];
      }
    }
  }

};

/**
 * The authority is the domain + port of a URI. Add a colon only if
 * the port is not empty.
 **/
__UriParser.Uri.prototype.authority = function() {
  return this.domain + ((this.port) ? ':' + this.port : '');
};

/**
 * Performs simple checks to ensure a URI part is not blank before
 * appending it to the return string.
 **/
__UriParser.Uri.prototype.toString = function() {
  var arr = [], str = '', url = '';
  if (this.protocol) { str += this.protocol + '://'; }
  if (this.authority()) { str += this.authority(); };
  if (this.path) { str += this.path; }
  for (key in this.query) arr.push(((this.query[key]) ? key + '=' + this.query[key] : key));
  if (arr.length) { str += '?' + arr.join('&'); } 
  if (this.anchor) { str += '#' + this.anchor; }
  return str;
};

/**
 * Returns a parsed Uri object of the given string. If no string is
 * provided it will parse the current page.
 **/
function parseUri(string) {
  return __UriParser.parseUri((arguments.length) ? string : window.location.toString());
}
