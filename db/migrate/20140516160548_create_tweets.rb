class CreateTweets < ActiveRecord::Migration
  def change
    # Very simplified; will probably need to be made more rigorous in the future
    create_table :tweets do |t|
      t.integer :twitter_id, limit: 8, null: false
      t.string :text, null: false # TODO: full text search
      t.string :user, null: false # twitter username, not a User. TODO: tie to Identity
      t.integer :favorited, default: 0
      t.integer :retweeted, default: 0
      t.text :raw, null: false # JSON encoded
      t.string :status, default: 'created' # -> linked

      t.integer :lock_version
      t.timestamps

      t.index :twitter_id, :unique => true
      t.index :user
      t.index [:favorited, :retweeted]
      t.index :status
    end

    create_table :searches do |t|
      t.string :term, null: false
      t.string :source, null: false # for now just 'Twitter'
      t.string :status, default: 'created', null: false
      t.integer :update_frequency # in seconds. nil = not automatically updated

      t.integer :lock_version
      t.timestamps

      t.index :status
      t.index [:source, :term], :unique => true
    end

    create_table :search_results do |t|
      t.references :search
      t.references :result, polymorphic: true

      t.datetime :created_at # doesn't change, so no need for updated

      t.index [:search_id, :result_type, :result_id], unique: true
    end

    create_table :links do |t|
      t.string :url, null: false
      t.references :duplicate_of, default: nil # the main (normalized, tracking-stripped) Link
      # nil until unshortened, = self if canonical

      t.integer :lock_version
      t.timestamps

      t.index :url, :unique => true
      t.index [:url, :duplicate_of_id]
    end

    create_table :tweet_links do |t|
      t.references :tweet, null: false
      t.references :link, null: false  # needs to go through #link.duplicate_of for unshortening

      t.index [:tweet_id, :link_id], unique: true # links in a tweet
      t.index [:link_id, :tweet_id] # tweets containing a link
    end
  end
end
