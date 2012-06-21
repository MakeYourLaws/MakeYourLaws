source 'http://rubygems.org'

gem 'rake', '>= 0.9.2.2'
gem 'rack', '>= 1.4.1'
gem 'rails', '>= 3.2.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', '>= 0.3.11'
gem 'json', '>= 1.6.6'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '>= 3.0.1'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '>= 2.12.0'
gem 'rvm-capistrano', '>= 1.1.0'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'


gem 'Empact-activerecord-import', '>= 0.4.1' # zdennis hasn't yet imported the import profiling fix; this is a bugfix tracking fork
gem "acts_as_audited", ">= 2.1.0"

gem "devise", ">= 2.0.4"
gem "devise-encryptable", ">= 0.1.1c"
gem "omniauth", ">= 1.1.0"
gem "omniauth-facebook", '>= 1.2.0'
gem "omniauth-github", '>= 1.0.1'
gem "omniauth-google-oauth2", '>= 0.1.9'
gem "omniauth-openid", '>= 1.0.1'
gem "omniauth-twitter", '>= 0.0.10'

gem "rails_email_validator", '>= 0.1.4'
gem "it", ">= 0.2.3"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'execjs', '>= 1.3.0'
  gem 'therubyracer', '>= 0.10.1'
  gem 'uglifier', '>= 1.2.4'
  gem 'sass-rails', '>= 3.2.5'
  gem 'coffee-rails', '>= 3.2.2'
end

gem 'jquery-rails', '>= 2.0.2'

gem "strip_attributes", ">= 1.1.0"
gem 'client_side_validations', ">= 3.1.4"
gem 'friendly_id'

gem 'exception_notification', '>= 2.6.1', :require => 'exception_notifier'
# gem "exception_logger", '>= 0.1.11' # currently incompatible w/ 3.1 :(
gem 'newrelic_rpm', ">= 3.4.0"

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'thin'
  
  case RUBY_VERSION
    when '1.8.7'
      gem 'ruby-debug'
    when '1.9.2', '1.9.3'
# there's an error with this; cf http://stackoverflow.com/questions/6438116/rails-with-ruby-debugger-throw-symbol-not-found-ruby-current-thread-loaderro
#      gem 'ruby-debug19', '>= 0.11.6', :require => 'ruby-debug'
  end
  
  gem 'webrat', '>= 0.7.3'
end
