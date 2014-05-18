class TweetLink < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :link # as tweeted; go through #link.duplicate_of to unshorten


  def self.add tweet_id, short, long = nil
    bestlink = Link.add_with_hint short, long
    self.find_or_create_by(tweet_id: tweet_id, link_id: bestlink.id)
  end

end
