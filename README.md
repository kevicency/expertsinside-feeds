ExpertsInside Feeds
===================

Small node app for fetching and aggregating various feeds (Twitter, Blog, ...)
for people working @ExpertsInside. The app is hosted on Azure under the URL
  http://expertsinside-feeds.azurewebsites.net and serves as a data backend for
  our company website.

The app is still under heavy development.

Getting started
---------------

Install dependencies

```sh
npm install
```

Run Tests with grunt.

```sh
grunt test
```

During active development you might want to use `grunt watch` which runs the
test on every filechange

Run local server

```sh
node server.js
```

If you have [nodemon](https://github.com/remy/nodemon) installed you can also do
which restarts the local server on every filechange

```sh
nodemon -e js,ls server.js
```
