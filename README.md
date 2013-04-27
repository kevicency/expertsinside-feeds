ExpertsInside Feeds
===================

Small node app for fetching and aggregating various feeds (Twitter, Blog, ...)
for people working @ExpertsInside. The app is hosted on Azure under the URL
  http://expertsinside-feeds.azurewebsites.net and serves as a data backend for
  our company website.

The app is still under heavy development.

[![Build Status](https://travis-ci.org/ExpertsInside/expertsinside-feeds.png)](https://travis-ci.org/ExpertsInside/expertsinside-feeds)

Getting started
---------------

### Install dependencies

```sh
npm install
```

### Run Tests with grunt.

```sh
grunt test
```

During active development you might want to use `grunt watch` which runs the
test on every filechange

### Run the app local

The app requires valid Twitter API keys to work. Since the app only reads the
public timeline, any Twitter App works. You can create one
[here](https://dev.twitter.com/apps). The following environment variables are
used for the keys

```
EI_TWITTER_CONSUMER_KEY
EI_TWITTER_CONSUMER_SECRET
EI_TWITTER_ACCESS_TOKEN_KEY
EI_TWITTER_ACCESS_TOKEN_SECRET
```

Running the app

```sh
node server.js
```

If you have [nodemon](https://github.com/remy/nodemon) installed you can also do
which restarts the local server on every filechange

```sh
nodemon -e js,ls server.js
```

References
----------

App is mostly written in [LiveScript](http://gkz.github.io/LiveScript/) using
[async](https://github.com/caolan/async) to handle the callback madness, 
[ntwitter](https://github.com/AvianFlu/ntwitter) for fetching tweets and
[express](http://expressjs.com/) for running the app.

Test are written with [Mocha](http://visionmedia.github.io/mocha/) using 
[Chai](http://chaijs.com/) syntax and [Sinon](http://sinonjs.org/) spies.

