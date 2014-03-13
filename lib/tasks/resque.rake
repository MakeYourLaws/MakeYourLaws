require 'resque/tasks'

task "resque:setup" => :environment

File.open( "log/resque.log", "a") {} # ensure it's there
Resque.logger = Logger.new("log/resque.log")

require 'resque_scheduler/tasks'
