TwitterStatus = require 'twitter_status'

class TwitterSearchQuery extends Spine.Model
  @configure 'TwitterQuery', 'query', 'results'
  @extend Spine.Model.Ajax

  @fetch: (query) ->
    throw 'query required' unless query
    @url = "http://search.twitter.com/search.json?callback=?&q=#{encodeURIComponent query}"
    super

  constructor: (atts) ->
    results = []
    for status in atts.results
      model = new TwitterStatus status
      model.save()
      results.push model

    super
      query: decodeURIComponent atts.query
      results: results

module.exports = TwitterSearchQuery