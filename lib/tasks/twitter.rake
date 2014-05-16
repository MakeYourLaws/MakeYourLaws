require 'twitter'
require 'uncoil'
require 'json'

# sometimes it thinks we're in root rather than /config
file =  File.join File.dirname(__FILE__), '..', 'keys.rb'
File.exists?(file) ? require(file) : require(File.join(File.dirname(__FILE__), 'lib', 'keys.rb'))

namespace :twitter do
  desc "Scrape for tweets & links related to the FEC Bitcoin decision"
  task :scrape => :environment do
    @linkfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_links.txt')
    @statefile = File.join(Rails.root, 'db', 'data', 'myl_twitter_state.txt')
    @tweetfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_tweets.txt')
    @plaintweetfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_tweets_plain.txt')

    @client = Twitter::REST::Client.new(:consumer_key => Keys.get('twitter_key'), :consumer_secret => Keys.get('twitter_secret'))

    if File.exist?(@linkfile)
      @unique_urls = File.read(@linkfile).split
    else
      @unique_urls = []
    end

    if File.exist?(@statefile)
      @search_terms = JSON.parse(File.read(@statefile))
    else
      @search_terms = {"fec bitcoin" => [0, 99999999999999999999], "@makeyourlaws" => [0, 99999999999999999999], "make your laws"  => [0, 99999999999999999999], "ao 2014-02" => [0, 99999999999999999999]}
    end

    if File.exist?(@tweetfile)
      @tweets = JSON.parse(File.read(@tweetfile))
    else
      @tweets = []
    end

    @uncoil = Uncoil.new
    @n = 0
    @urls = []

    def extract_stats tweet
      stats = {}
      if tweet.respond_to? :user
        stats[:fol] = tweet.user.followers_count
        stats[:fav] = tweet.favorite_count
        stats[:rt] = tweet.retweet_count
        stats[:name] = tweet.user.screen_name
        stats[:txt] = tweet.full_text || tweet.txt
      elsif tweet.has_key? :user
        stats[:fol] = tweet[:user][:followers_count]
        stats[:fav] = tweet[:favorite_count]
        stats[:rt] = tweet[:retweet_count]
        stats[:name] = tweet[:user][:screen_name]
        stats[:txt] = tweet[:full_text] || tweet[:text]
      elsif tweet.has_key? 'user'
        stats[:fol] = tweet['user']['followers_count']
        stats[:fav] = tweet['favorite_count']
        stats[:rt] = tweet['retweet_count']
        stats[:name] = tweet['user']['screen_name']
        stats[:txt] = tweet['full_text'] || tweet['text']
      else
        raise "unable to parse tweet #{tweet.inspect}"
      end
      stats
    end

    def format_tweet tweet
      stats = extract_stats tweet

       "fol #{stats[:fol]} fav #{stats[:fav]} rt #{stats[:rt]} | @#{stats[:name]}: #{stats[:txt]}"
    end

    def save_and_print search_term
      puts "\n" * 5, 'saving...'
      if !@urls.blank?
        @unique_urls += [@uncoil.expand(@urls)].flatten.map{|u| u.long_url.sub(/\?utm_.+$/, '').sub(/\&utm_.+$/, '')}
        @urls = []
        @unique_urls.uniq!
        @unique_urls.sort!{|a,b| a[/:\/\/[^\/]+/].split('.').reverse <=> b[/:\/\/[^\/]+/].split('.').reverse}

        File.open(@linkfile, 'w'){|f| f.write(@unique_urls.join("\n")) }
      end

      File.open(@statefile, 'w'){|f| f.write(@search_terms.to_json) }
      File.open(@tweetfile, 'w'){|f| f.write(@tweets.to_json) }
      File.open(@plaintweetfile, 'w') {|f| f.write(@tweets.sort do |a,b|
        stats_a = extract_stats a
        stats_b = extract_stats b
        (stats_a[:fav] + stats_a[:rt]) <=> (stats_b[:fav] + stats_b[:rt])
      end.map{|tweet| format_tweet tweet}.join("\n")) }

      puts "new tweets: #{@n}, new urls: #{@unique_urls.size - @unique_urls_old.size}, max = #{@search_terms[search_term][0]}, min = #{@search_terms[search_term][1]}", "\n" * 5
    end

    def update_and_print search_term, tweet
      unless @tweets.include? tweet.to_h
        @n += 1
        tweet.urls.map{|u| @urls << u.expanded_url.to_s }
        @search_terms[search_term][0] = tweet.id if tweet.id > @search_terms[search_term][0]
        @search_terms[search_term][1] = tweet.id if tweet.id < @search_terms[search_term][1]
        @tweets << tweet.to_h
        puts format_tweet(tweet)
      end
    end

    @unique_urls_old = @unique_urls.dup

    @search_terms.each do |search_term, maxmin|
      puts search_term, maxmin
      @n = 0

      # Get all historical items
      i = 1
      while i > 0 do
        i = 0
        puts "searching: #{search_term}, :result_type => 'recent', :max_id => #{maxmin[1] - 1}"
        @client.search(search_term, :result_type => 'recent', :max_id => maxmin[1] - 1).each do |tweet|
          i += 1
          update_and_print search_term, tweet
        end rescue retry
        save_and_print search_term
        puts i
      end

      # Get all items since last update
      i = 1
      while i > 0 do
        i = 0
        puts "searching: '#{search_term}', :result_type => 'recent', :since_id => #{maxmin[0]}"
        @client.search(search_term, :result_type => 'recent', :since_id => maxmin[0]).each do |tweet|
          i += 1
          update_and_print search_term, tweet
        end rescue retry
        save_and_print search_term
        puts i
      end
    end
  end
end
