require! express
require! Tweets: './tweets'

module.exports = (options = {}) ->
  app = express()
  tweets = app.tweets = options.tweets || new Tweets()

  app.get '/tweets/:slug', (req,res) ->
    slug = req.params.slug

    # Check if valid slug
    if not Tweets.ScreenNames[slug]? then res.send 404

    err, data <- tweets.userTimeline do
      slug: slug
      count: +req.query.count

    if err?
      res.send(500, error: err)
    else
      res.json data

  app.get '/tweets', (req,res) ->
    err, data <- tweets.timeline do
      count: +req.query.count

    if err?
      res.send(500, error: err)
    else
      res.json data

  return app
