TWITTER = Twitter::REST::Client.new(consumer_key:    Keys.get('twitter_key'),
                                    consumer_secret: Keys.get('twitter_secret'))
