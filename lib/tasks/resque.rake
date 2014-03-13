require 'resque/tasks'

task "resque:setup" => :environment

Resque.logger = Logger.new("log/resque.log")

require 'resque_scheduler/tasks'
