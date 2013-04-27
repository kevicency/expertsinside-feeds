App = require '../lib/app'
request = require 'supertest'
app = null
tweets = null
_it = it

describe "app", ->
  beforeEach ->
    app := App!

  describe 'GET /tweets/:slug', ->
    Tweets = require '../lib/Tweets'
    slug = [slug for slug of Tweets.ScreenNames][0]

    _it 'returns 500 on error', (done) ->
      userTimeline = sinon.stub app.tweets, "userTimeline"
      userTimeline.yields "Error"

      request(app)
        .get "/tweets/#slug"
        .expect 500, done

    _it 'returns 404 on invalid slug', (done) ->
      request(app)
        .get '/tweets/qux'
        .expect 404, done

    _it 'accepts query: count', (done) ->
      userTimeline = sinon.stub app.tweets, "userTimeline"
      userTimeline.yields null, []

      err, res <- request(app)
        .get "/tweets/#slug?count=1"
        .end

      userTimeline.should.have.been.calledWithMatch {count: 1}
      done!

    _it 'returns latest tweets as json', (done) ->
      userTimeline = sinon.stub app.tweets, "userTimeline"
      data = require './data/timeline'
      userTimeline.yields null, data

      err, res <- request(app)
        .get "/tweets/#slug"
        .expect 200
        .expect 'Content-Type', /json/
        .end

      if err then done err
      userTimeline.should.have.been.calledOnce
      userTimeline.should.have.been.calledWithMatch {slug}
      res.body.should.be.eql data
      done!

  describe 'GET /tweets', ->
    _it 'returns 500 on error', (done) ->
      timeline = sinon.stub app.tweets, "timeline"
      timeline.yields "Error"

      request(app)
        .get '/tweets'
        .expect 500, done

    _it 'returns latest tweets as json', (done) ->
      timeline = sinon.stub app.tweets, "timeline"
      data = require './data/timeline'
      timeline.yields null, data

      err, res <- request(app)
        .get '/tweets'
        .expect 200
        .expect 'Content-Type', /json/
        .end

      if err then done err
      res.body.should.be.eql data
      done!


