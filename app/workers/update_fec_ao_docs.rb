class UpdateFecAoDocs
  @queue = :fec_docs
  extend Resque::Plugins::JobStats
  extend Resque::Plugins::LockTimeout
  @loner = true
  @lock_timeout = 120

  # extend Resque::Plugins::Retry
  # @retry_delay = 60
  extend Resque::Plugins::ExponentialBackoff
  @retry_delay_multiplicand_max = 1.1 # https://github.com/lantins/resque-retry/pull/102

  @retry_limit = 3
  # @sleep_after_requeue = 5

  # @retry_exceptions = [OnlyRetryThisError]
  # @retry_exceptions = { NetworkError => 30, SystemCallError => [120, 240] }
  # @fatal_exceptions = [DontRetryThisError]
  # def self.retry_args(same_args_as_perform)
  #   [new_args_for_perform]
  # end

  def self.perform # args
    FecAoDocs.get_this_year
    FecAoDocs.get_pending
  end
end
