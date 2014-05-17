class Tweet < ActiveRecord::Base
  has_many :tweet_links
  has_many :links, through: :tweet_links
  has_many :search_results, as: :result
  has_many :searches, through: :search_results

  scope :unlinked, -> {where(status: 'created')}

  def self.save_from_twitter tweet
    t = self.find_or_initialize_by(twitter_id: tweet.id)
    t.update(text: (tweet.full_text || tweet.txt), user: tweet.user.screen_name,
      favorited: tweet.favorite_count, retweeted: tweet.retweet_count,
      raw: tweet.to_json)
    t
  end

  def linkify!
    urls  = []
    raw = JSON.parse(self.raw)
    raw['entities']['urls'].map do |u|
      TweetLink.add(self.id, u['url'], u['expanded_url'])
      TweetLink.add(self.id, "http://#{u['display_url']}", u['expanded_url'])
    end
    self.update_attribute :status, 'linked'
  end

  def self.search search
    search.update_attribute :status, 'processing'

    begin
      [{:result_type => 'recent', :max_id => ->{(search.results.maximum(:twitter_id) || 0)  - 1}},
        {:result_type => 'recent', :since_id => ->{search.results.minimum(:twitter_id) || 99999999999999999999}}].each do |param|
        i = 1
        while i > 0 do
          i = 0
          logger.info "Scraping twitter: #{param}"
          TWITTER.search(search.term, param).each do |tweet|
            i += 1
            t = Tweet.save_from_twitter(tweet)
            begin
              search.results << t
            rescue ActiveRecord::RecordNotUnique
            end
          end
          logger.info "... scraped #{i} result(s)"
        end
      end

      search.update_attribute :status, 'done'
    rescue Twitter::Error::TooManyRequests
      search.update_attribute :status, 'api_limit'
    end
    search
  end
end
