require 'twitter'
require 'uncoil'
require 'json'

# sometimes it thinks we're in root rather than /config
file =  File.join File.dirname(__FILE__), '..', 'keys.rb'
File.exists?(file) ? require(file) : require(File.join(File.dirname(__FILE__), 'lib', 'keys.rb'))

namespace :twitter do
  desc "Scrape for tweets & links related to the FEC Bitcoin decision"
  task :scrape => :environment do
    linkfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_links.txt')
    statefile = File.join(Rails.root, 'db', 'data', 'myl_twitter_state.txt')
    tweetfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_tweets.txt')
    plaintweetfile = File.join(Rails.root, 'db', 'data', 'myl_twitter_tweets_plain.txt')

    @client = Twitter::REST::Client.new(:consumer_key => Keys.get('twitter_key'), :consumer_secret => Keys.get('twitter_secret'))

    if File.exist?(linkfile)
      @unique_urls = File.read(linkfile).split
    else
      @unique_urls = []
    end

    if File.exist?(statefile)
      @search_terms = JSON.parse(File.read(statefile))
    else
      @search_terms = {"fec bitcoin" => [0, 99999999999999999999], "@makeyourlaws" => [0, 99999999999999999999], "make your laws"  => [0, 99999999999999999999], "ao 2014-02" => [0, 99999999999999999999]}
    end

    if File.exist?(tweetfile)
      @tweets = JSON.parse(File.read(tweetfile))
    else
      @tweets = []
    end

    def save_and_print search_term
      @unique_urls.map!{|u| u.sub(/\?utm_.+$/, '').sub(/\&utm_.+$/, '') }
      @unique_urls.uniq!
      @unique_urls.sort!{|a,b| a[/:\/\/[^\/]+/].split('.').reverse <=> b[/:\/\/[^\/]+/].split('.').reverse}

      File.open(linkfile, 'w'){|f| f << @unique_urls.join("\n") }
      File.open(statefile, 'w'){|f| f << @search_terms.to_json }
      File.open(tweetfile, 'w'){|f| f << @tweets.to_json }
      File.open(plaintweetfile, 'w') {|f| f << @tweets.sort{|a,b| a[:favorite_count] + a[:retweet_count] <=> b[:favorite_count] + b[:retweet_count] }.map{|tweet| "fav #{tweet.favorite_count} rt #{tweet.retweet_count} | @#{tweet.user.screen_name}: #{tweet.full_text}"}.join("\n") }

      puts "\n" * 5, "new tweets: #{@n}, new urls: #{@unique_urls.size - @unique_urls_old.size}, max = #{@search_terms[search_term][0]}, min = #{@search_terms[search_term][1]}"
    end

    def update_and_print search_term, tweet
      unless @tweets.include? tweet.to_h
        @n += 1
        tweet.urls.map{|u| @unique_urls << Uncoil.expand(u.expanded_url.to_s).long_url }
        @unique_urls.uniq!
        @search_terms[search_term][0] = tweet.id if tweet.id > @search_terms[search_term][0]
        @search_terms[search_term][1] = tweet.id if tweet.id < @search_terms[search_term][1]
        @tweets << tweet.to_h
        puts "fav #{tweet.favorite_count} rt #{tweet.retweet_count} | @#{tweet.user.screen_name}: #{tweet.full_text}"
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
          save_and_print search_term
        end rescue retry
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
          save_and_print search_term
        end rescue retry
        puts i
      end
    end
  end
end
