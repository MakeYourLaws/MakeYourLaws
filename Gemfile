source 'https://code.stripe.com'

gem 'stripe'


source 'https://rubygems.org'

platform(:rbx) do
  gem 'rubysl'
  gem 'ffi'
end
platform(:jruby) { gem 'jruby-openssl' }

gem 'puma'

gem 'rails', '>= 4.0.1'
gem 'rake', '>= 0.9.2.2'
gem 'rack', '>= 1.4.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'redis-rails' # switching out for dalli/memcached

gem "resque", require: "resque/server"
gem "capistrano-resque", git: "https://github.com/sshingler/capistrano-resque.git", require: false
gem 'resque_mailer'
gem 'resque-scheduler', require: 'resque_scheduler/server'
gem 'resque-retry', require: ['resque-retry', 'resque-retry/server']
gem 'resque-job-stats', require: ['resque-job-stats/server', 'resque/plugins/job_stats']

# gem 'newrelic_rpm', ">= 3.4.0" # might be interfering with resque
gem 'airbrake'
# gem 'exception_notification', '>= 4.0.1' # deprecated for airbrake.io
# gem "exception_logger", '>= 0.1.11' # currently incompatible w/ 3.1 :(

gem 'rack-cache'
gem 'rack-tor-tag'
gem 'rack-attack'

platform(:rbx, :mri) { gem 'mysql2' }
platform(:jruby) { gem 'jdbc-mysql' }
gem 'json', '>= 1.6.6'
gem 'jbuilder', '>= 1.2' # JSON APIs. https://github.com/rails/jbuilder

gem 'bcrypt', '>= 3.0.1' # To use ActiveModel has_secure_password

# Use unicorn as the web server
# gem 'unicorn'

group :development do
  gem 'capistrano', '>= 3.0.1', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false

  # gem 'capistrano-ci' # not cap3 compatible yet https://github.com/railsware/capistrano-ci/pull/4
  gem 'term-ansicolor'
  platform(:mri) { gem 'debugger' }
  platform(:jruby) { gem 'ruby-debug' }
  platform(:rbx) do
    gem 'rubinius-compiler'
    gem 'rubinius-debugger'
  end
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  platform(:mri) { gem 'ruby-prof' }
  gem 'webrat', '>= 0.7.3'
  gem "brakeman", :require => false  # Rails security scanner
  gem 'rspec-rails', '~> 3.0.0.beta'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

gem 'Empact-activerecord-import', '>= 0.4.1' # zdennis hasn't yet imported the import profiling fix; this is a bugfix tracking fork
gem "paper_trail", '>= 3.0.0'

# NoMethodError: undefined method `[]' for #<ActiveRecord::Reflection::AssociationReflection:0x007fe9a2743860>
# gem 'has_many_polymorphs', github => 'jystewart/has_many_polymorphs'

# gem 'apotomo' # provides cells. not rails 4 compatible
gem 'state_machine'

# use MYL's fork of NYT's Fech gem, since it has bugfixes and other features that NYT hasn't committed
gem 'myl-fech', '>= 1.0.2', :require => 'fech'

gem 'money', '>= 5.0.0'
gem 'money-rails'
gem "active_paypal_adaptive_payment"

gem 'stripe_event'

gem 'jwt' # for Google Wallet

gem 'amazon_flex_pay'

gem 'bitpay-client', :require => 'bitpay'

gem "devise", ">= 3.1.1"
gem "devise-encryptable", ">= 0.1.1c"
gem "omniauth", ">= 1.1.0"
gem "omniauth-facebook", '>= 1.2.0'
gem "omniauth-github", '>= 1.0.1'
gem "omniauth-google-oauth2", '>= 0.1.9'
gem "omniauth-openid", '>= 1.0.1'
gem "omniauth-twitter", '>= 0.0.10'
gem "omniauth-paypal", '>= 1.2.1'

gem 'devise-async'

gem 'cancan', '>= 1.6.8'
# gem 'cantango', '>= 0.9.4.7'
gem 'rolify'

gem "rails_email_validator", '>= 0.1.4'
gem "it", ">= 0.2.3"

gem 'execjs', '>= 1.3.0' # See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '>= 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'sass-rails', '>= 4.0.0' # Use SCSS for stylesheets

gem 'jquery-rails', '>= 2.0.2'
gem 'jquery-ui-rails'

gem 'turbolinks' # makes links load faster; see https://github.com/rails/turbolinks

# gem 'jquery_datepicker' # rails 4 incompatible 2013-06-29
gem 'bettertabs'
gem 'phone'

gem 'kramdown' # more jruby-friendly than rdiscount

gem "strip_attributes", ">= 1.1.0"
# gem 'client_side_validations' # rails 4 incompatible

gem 'friendly_id', ">= 5.0.0"

