Tweets = require('../lib/tweets')

_it = it

describe \Tweets, ->
  subject = null
  beforeEach -> subject := new Tweets

  _it '.ApiKeys', ->
    ApiKeys = Tweets.ApiKeys
    ApiKeys.should.be.an 'Object'
    ApiKeys.should.have.property 'consumer_key', 'foo'
    ApiKeys.should.have.property 'consumer_secret', 'bar'
    ApiKeys.should.have.property 'access_token_key', 'baz'
    ApiKeys.should.have.property 'access_token_secret', 'qux'

  _it \.ScreenNames, ->
    ScreenNames = Tweets.ScreenNames
    ScreenNames.should.be.an \Object
    ScreenNames.should.have.property \km
    ScreenNames.should.have.property \hg
    ScreenNames.should.have.property \nb
    ScreenNames.should.have.property \cg
    ScreenNames.should.have.property \szu

  describe \#client, ->
    beforeEach -> subject := new Tweets foo: "bar"

    for k,v of Tweets.ApiKeys
      _it "should know #{k}", ->
        subject.client.options.should.have.property k, v

    _it "gets passed options", ->
      subject.client.options.should.have.property "foo", "bar"

  describe \#userTimeline, ->
    api = null
    beforeEach ->
      api := sinon.stub subject.client, \getUserTimeline
    after ->
      subject.client.getUserTimeline.restore!

    _it "accepts options.count", ->
      subject.userTimeline count: 1

      api.should.have.been.calledWithMatch count: 1

    _it "options.count defaults to 3", ->
      subject.userTimeline {}, ->

      api.should.have.been.calledWithMatch count: 3

    _it "retrieves screenName from options.slug", ->
      Tweets.ScreenNames.foo = \bar

      subject.userTimeline slug: \foo

      api.should.have.been.calledWithMatch screen_name: \bar

    _it "on fail: invokes callback with error", ->
      cb = sinon.spy!

      subject.userTimeline {}, cb
      api.yield "Error"

      cb.should.have.been.calledWith "Error", void

    _it "on success: invokes callback with result", ->
      cb = sinon.spy!
      data = [1,2,3]

      subject.userTimeline {}, cb
      api.yield null, data

      cb.should.have.been.calledWith null, data

  describe \#timeline, ->
    api = null
    beforeEach ->
      api := sinon.stub subject, \userTimeline
    after ->
      subject.userTimeline.restore!

    _it "accepts options.count", ->
      subject.timeline count: 1

      api.should.have.been.calledWithMatch count: 1

    _it "options.count defaults to 3", ->
      subject.timeline!

      api.should.have.been.calledWithMatch count: 3

    _it "aggregates all user timelines", ->
      slugs = [slug for slug of Tweets.ScreenNames]
      subject.timeline!

      for slug in slugs
        api.should.have.been.calledWithMatch {slug}

    _it "on success: invokes callback with aggregated tweets", ->
      cb = sinon.spy!

      subject.timeline {}, cb
      for i til api.callCount
        id_str = "#i"
        api.getCall i .yield null, [{id_str}]

      cb.should.have.been.calledOnce
      cb.should.have.been.calledWith null,
        * * id_str: "#{api.callCount-1}"
          * id_str: "#{api.callCount-2}"
          * id_str: "#{api.callCount-3}"

    _it "on fail: invokes callback with error", ->
      cb = sinon.spy!

      subject.timeline {}, cb
      api.yield "Error"

      cb.should.have.been.calledWith "Error", void
