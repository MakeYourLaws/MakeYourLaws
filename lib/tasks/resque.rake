require 'resque/tasks'
require 'resque_scheduler/tasks'

def set_log log_name
  logfile = File.open(File.join(Rails.root, 'log', log_name), 'a')
  logfile.sync = true
  Resque.logger = ActiveSupport::Logger.new(logfile)
  Resque.logger.level = Logger::INFO
  Resque.logger.formatter = Resque::VeryVerboseFormatter.new
end

set_log 'resque_base.log'

task "resque:setup" => :environment do
  Resque.before_fork = Proc.new {
    ActiveRecord::Base.establish_connection

    queue_name = Resque.queue_from_class(self)
    set_log(queue_name ? "resque_#{queue_name}.log" : 'resque_worker.log')
  }
end