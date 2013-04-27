require('LiveScript');

var chai = require("chai");
var sinonChai = require("sinon-chai");

chai.use(sinonChai);
should = require('chai').should();
sinon = require('sinon');

process.env['EI_TWITTER_CONSUMER_KEY'] = 'foo';
process.env['EI_TWITTER_CONSUMER_SECRET'] = 'bar';
process.env['EI_TWITTER_ACCESS_TOKEN_KEY'] = 'baz';
process.env['EI_TWITTER_ACCESS_TOKEN_SECRET'] = 'qux';
