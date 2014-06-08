class TwitterScraper
  @queue = :twitter_scraper
  extend Resque::Plugins::JobStats
  extend Resque::Plugins::LockTimeout
  @loner = true

  # extend Resque::Plugins::Retry
  # @retry_delay = 60
  extend Resque::Plugins::ExponentialBackoff

  @retry_limit = 3
  # @sleep_after_requeue = 5

  # @retry_exceptions = [OnlyRetryThisError]
  # @retry_exceptions = { NetworkError => 30, SystemCallError => [120, 240] }
  # @fatal_exceptions = [DontRetryThisError]
  # def self.args_for_retry(same_args_as_perform)
  #   [new_args_for_perform]
  # end

  def self.perform # args
    s = Search.pending.first
    Tweet.search s if s
  end

end