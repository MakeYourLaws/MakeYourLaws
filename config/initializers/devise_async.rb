Devise::Async.setup do |config|
  config.enabled = true
  # Supported options: :resque, :sidekiq, :delayed_job, :queue_classic, :torquebox
  config.backend = :resque
  config.queue   = :mailer
end