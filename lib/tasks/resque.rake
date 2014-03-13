require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  Resque.before_fork = Proc.new {
    ActiveRecord::Base.establish_connection

    # Open the new separate log file
    logfile = File.open(File.join(Rails.root, 'log', 'resque.log'), 'a')

    # Activate file synchronization
    logfile.sync = true

    # Create a new buffered logger
    Resque.logger = ActiveSupport::BufferedLogger.new(logfile)
    Resque.logger.level = Logger::INFO
    Resque.logger.info "Resque Logger Initialized!"
  }
end