class Tweet < ActiveRecord::Base
  has_many :tweet_links
  has_many :links, through: :tweet_links
  has_many :search_results, as: :result
  has_many :searches, through: :search_results

  scope :unlinked, -> { where(status: 'created') }

  def self.save_from_twitter tweet
    t = find_or_initialize_by(twitter_id: tweet.id)
    t.update(text: (tweet.full_text || tweet.txt), user: tweet.user.screen_name,
      favorited: tweet.favorite_count, retweeted: tweet.retweet_count,
      raw: tweet.to_h.to_json)
    t
  end

  def linkify!
    raw = JSON.parse(self.raw)
    raw['entities']['urls'].map do |u|
      TweetLink.add(id, u['url'], u['expanded_url'])
      TweetLink.add(id, "http://#{u['display_url']}", u['expanded_url'])
    end
    update_attribute :status, 'linked'
  end

  def self.search search
    search.update_attribute :status, 'processing'
    begin
      [
        lambda do |s|
          { result_type: 'recent',
            max_id:      (s.results.minimum(:twitter_id) || 99_999_999_999_999_999_999)  - 1
          }
        end,
        lambda do |s|
          { result_type: 'recent',
            since_id:    (s.results.maximum(:twitter_id) || 0)
          }
        end
      ].each do |param|
        i = 1
        while i > 0
          i = 0
          this_param = param.call(search)
          logger.info "Scraping twitter for #{search.term}: #{this_param}"
          TWITTER.search(search.term, this_param).each do |tweet|
            i += 1
            t = Tweet.save_from_twitter(tweet)
            begin
              search.results << t
            rescue ActiveRecord::RecordNotUnique
              next
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
