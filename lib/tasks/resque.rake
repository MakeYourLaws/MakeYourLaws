require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'resque-retry'
require 'resque/failure/redis'
require 'resque/failure/airbrake'
require 'resque/pool/tasks'

Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression

# Monkeypatch to fix reconnection issues. See https://github.com/resque/resque/pull/1193
module Resque
  class Worker
    alias_method :orig_startup, :startup
    def startup
      reconnect
      orig_startup
    end

    alias_method :orig_unregister_worker, :unregister_worker
    def unregister_worker exception = nil
      log "#{exception.render}" if exception
      orig_unregister_worker(exception)
    end
  end
end

def reset_log log_name
  logfile = File.open(File.join(Rails.root, 'log', log_name), 'a')
  logfile.sync = true
  Resque.logger = ActiveSupport::Logger.new(logfile)
  Resque.logger.level = Logger::INFO
  Resque.logger.formatter = Resque::VeryVerboseFormatter.new
  Resque.logger.info "#{log_name} logger initiated"
end

reset_log 'resque_base.log'

task 'resque:setup' => :environment do
  reset_log 'resque_setup.log'

  # Proc.new instead of lambda because args might not be passed
  #  (and lambda does strict argument checking)
  Resque.before_first_fork = Proc.new {|args|   # for the parent
    queue_name = args.try(:queue)
    reset_log(queue_name ? "resque_#{queue_name}_parent.log" : 'resque_worker_parent.log')
  }

  Resque.after_fork = Proc.new {|args|    # for the child
    queue_name = args.try(:queue)
    reset_log(queue_name ? "resque_#{queue_name}.log" : 'resque_worker.log')
    ActiveRecord::Base.establish_connection
  }

  # Resque::Scheduler.dynamic = true
  Resque::Scheduler.configure do |c|
    reset_log 'resque_scheduler.log'
  end
  Resque.schedule = YAML.load_file(File.join(Rails.root, 'config', 'resque_schedule.yml'))
end

# Example usage:
#  Resque.enqueue_in(5.days, SendFollowUpEmail, :user_id => current_user.id)
# or remove the job later:
#  # with exactly the same parameters
#  Resque.remove_delayed(SendFollowUpEmail, :user_id => current_user.id)
#  # or partial matching
#  Resque.remove_delayed_selection { |args| args[0]['user_id'] == current_user.id }

task 'resque:pool:setup' do
  reset_log 'resque_pool_setup.log'

  # close any sockets or files in pool manager
  ActiveRecord::Base.connection.disconnect!
  # and re-open them in the resque worker parent
  Resque::Pool.after_prefork do |_job|
    reset_log 'resque_pool.log'
    ActiveRecord::Base.establish_connection
    Resque.redis.client.reconnect
  end
end
