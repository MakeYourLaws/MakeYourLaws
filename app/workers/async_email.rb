class AsyncEmail < Mailhopper::Email
  @queue = :mailer
  extend Resque::Plugins::JobStats
  extend Resque::Plugins::LockTimeout
  extend Resque::Plugins::Retry
  @retry_delay = 60
  @lock_timeout = 120
  extend Resque::Plugins::ExponentialBackoff
  @retry_delay_multiplicand_max = 1.1 # https://github.com/lantins/resque-retry/pull/102

  @retry_limit = 3

  after_create :async_send

  def self.perform(email_id)
    Mailhopper::Email.find(email_id).send!
  end

  private

  def async_send
    Resque.enqueue(self.class, self.id)
  end
end
