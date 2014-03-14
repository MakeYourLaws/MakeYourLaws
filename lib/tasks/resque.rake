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
    queue_name = Resque.queue_from_class(self)
    set_log(queue_name ? "resque_#{queue_name}.log" : 'resque_worker.log')
  }

  Resque.after_fork = Proc.new {
    ActiveRecord::Base.establish_connection
    Rails.cache.reconnect
    Resque.redis.client.reconnect
  }

  # Resque::Scheduler.dynamic = true
  Resque::Scheduler.configure do |c|
    logfile = File.open(File.join(Rails.root, 'log', 'resque_scheduler.log'), 'a')
    logfile.sync = true
    c.mute = false
    c.verbose = true
    c.logfile = logfile
    c.logformat = 'text'
  end
  Resque.schedule = YAML.load_file(File.join(Rails.root, 'config', 'resque_schedule.yml'))
end

# Example usage:
#  Resque.enqueue_in(5.days, SendFollowUpEmail, :user_id => current_user.id)
# or remove the job later:
#  Resque.remove_delayed(SendFollowUpEmail, :user_id => current_user.id) # with exactly the same parameters
#  Resque.remove_delayed_selection { |args| args[0]['user_id'] == current_user.id } # or partial matching