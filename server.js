#!/usr/bin/env nodemon -e js,ls

require('LiveScript');

var app = require('./lib/app')();

var port = process.env.PORT || 3000;
app.listen(port);
console.log("Listening on port " + port);
