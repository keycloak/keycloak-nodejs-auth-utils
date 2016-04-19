
var test = require('tape');
var Config = require('../lib/config');

test('Config should load the json file.', function (t) {
  
  t.equal(new Config('test/keycloak.json').realm, 'nodejs-test');
  t.end();

}); 