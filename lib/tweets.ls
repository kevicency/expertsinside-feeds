require! _: lodash
require! <[async ntwitter]>
#require! \prelude-ls .map

module.exports = class Tweets
  const @ScreenNames =
    km: 'kevin_mees'
    cg: 'cglessner'
    hg: 'TheMossShow'
    nb: 'NickiBorell'
    szu: 'SharePointSzu'

  const @ApiKeys = do ->
    _.reduce <[consumer_key consumer_secret access_token_key access_token_secret]>, (keys, key) ->
      envKey = "EI_TWITTER_#{key.toUpperCase()}"
      keys[key] = process.env[envKey]
      keys
    , (new Object)

  (options = {}) ->
    options = _.merge(@@ApiKeys, options)
    @client = new ntwitter(options)

  userTimeline: (options = {}, callback = ->) ->
    screenName = @@ScreenNames[options.slug]
    count = options.count || 3

    @client.getUserTimeline do
      screen_name: screenName
      count: count
      include_rts: true
      include_entities: true
      callback

  timeline: (options = {}, callback = ->) ->
    count = options.count || 3
    slugs = [slug for slug of @@ScreenNames]
    err, userTimelines <- async.map slugs, (slug, cb) ~> @userTimeline {slug, count}, cb

    timeline = _ userTimelines
      .flatten!
      .sortBy \id_str
      .reverse!
      .first count
      .value! unless err?
    callback err, timeline
