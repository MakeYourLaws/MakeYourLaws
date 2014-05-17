class TweetLink < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :link # as tweeted; go through #link.duplicate_of to unshorten


  def self.add tweet_id, short, long = nil
    bestlink = nil
    if long
      uncoiled = Uncoil.expand(long).long_url
      if uncoiled != long
        bestlink = Link.add_by_url(uncoiled)
        longlink = Link.add_by_url(long)
        longlink.update_attribute :duplicate_of_id, bestlink.id
      else
        bestlink = Link.add_by_url(long)
      end
    end
    bestlink = shortlink if !bestlink

    if bestlink.uncrufted != bestlink.url
      uncrufted = Link.add_by_url(bestlink.uncrufted)
      bestlink.update_attribute :duplicate_of_id, uncrufted.id
      bestlink = uncrufted
    end

    bestlink.update_attribute :duplicate_of_id, bestlink.id

    shortlink = Link.add_by_url(short)
    # needs to be updated post creation to get its own link
    shortlink.update_attribute(:duplicate_of_id, bestlink.id)

    self.find_or_create_by(tweet_id: tweet_id, link_id: bestlink.id)
  end

end
