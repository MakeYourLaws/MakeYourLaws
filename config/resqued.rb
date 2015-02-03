# worker 'high'
# worker 'low', :interval => 30

worker_pool 2, :interval => 1
# queue 'high', 'almosthigh'
# queue 'low', :percent => 20
# queue 'normal', :count => 4
queue '*'

def reset_log log_name
  logfile = File.open(File.expand_path(File.join('../..', 'log', log_name), __FILE__), 'a')
  logfile.sync = true
  Resque.logger = MonoLogger.new(logfile)
  Resque.logger.level = Logger::INFO
  Resque.logger.formatter = Resque::VeryVerboseFormatter.new
  Resque.logger.info "#{log_name} logger initiated"
end

environment = ENV["RACK_ENV"] || ENV["RAILS_ENV"] || ENV["RESQUE_ENV"] || 'production'
ENV["RACK_ENV"] = ENV["RAILS_ENV"] = ENV["RESQUE_ENV"] = environment

reset_log 'resqued.log'

before_fork do
  reset_log 'resqued_worker_prefork.log'
  require "./config/environment.rb"
  Rails.application.eager_load!
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |worker|
  reset_log 'resqued_worker_postfork.log'
  ActiveRecord::Base.establish_connection
  worker.term_timeout = 1.minute
end