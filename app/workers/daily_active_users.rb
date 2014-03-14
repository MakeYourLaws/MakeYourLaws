class DailyActiveUsers
  @queue = :active_users

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
    dau = User.where(updated_at: (Time.now.midnight - 1.day)..Time.now.midnight).count
    day = Date.today - 1
    AdminMailer.dau(day, dau).deliver
  end

end