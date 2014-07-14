# This file is used by Rack-based servers to start the application.
require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

use Rack::Cache,
    metastore:   'redis://localhost:6379/3',
    entitystore: 'redis://localhost:6379/4'

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
