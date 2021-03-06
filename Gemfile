source 'https://code.stripe.com' do

  gem 'stripe'

end

source 'https://rubygems.org' do

  platform(:rbx) do
    gem 'rubysl'
    gem 'ffi'
  end

  # Use Psych as the YAML engine, instead of Syck, so serialized data can be read safely from different rubies (see http://git.io/uuLVag)
  gem 'psych', '>= 2.0'

  gem 'puma'

  gem 'rails', '>= 4.2.6' #, '>= 4.0.1'
  gem 'rake'#, '>= 0.9.2.2'
  gem 'rack'#, '>= 1.4.1'

  gem 'sprockets'

  group :doc do
    # bundle exec rake doc:rails generates the API under doc/api.
    gem 'sdoc', '>= 0.4.0', require: false
  end

  # gem 'hashie', '>= 3.2.0'
  # Inclusion causes error:
  #  Superclass mismatch: Object != Hashie::Mash (TypeError)
  #
  #   Rubinius.open_class_under at kernel/delta/rubinius.rb:334
  #  { } in Object(Module)#__script__ at
  #   ~/.rvm/gems/rbx-2.2.10/gems/active_paypal_adaptive_payment-0.3.16/lib
  #    /active_merchant/billing/gateways/paypal_adaptive_payments/ext.rb:7
  # Haven't diagnosed why. Works fine without.

  # gem 'hashie_rails'  # see https://github.com/intridea/hashie/blob/master/UPGRADING.md
  gem 'hashie-forbidden_attributes'
  # moved from hashie-rails
  # see https://github.com/intridea/hashie/blob/master/UPGRADING.md

  gem 'redis-rails', '>= 5' # switching out for dalli/memcached
#  gem "redis-rack-cache" # having issues in travis: https://travis-ci.org/MakeYourLaws/MakeYourLaws/jobs/158981389
#  gem 'redis-session-store'

  gem "resque", require: "resque/server"
  gem 'sinatra', '>= 2.0.0.beta2' # required by resque; v1 has error https://github.com/sinatra/sinatra/issues/1055, v1.4.7 uses older version of Rack
  gem 'resque_mailer'
  gem 'resque-scheduler', require: 'resque/scheduler/server'
  gem 'resque-retry', require: ['resque-retry', 'resque-retry/server']
  gem 'resque-job-stats', require: ['resque-job-stats/server', 'resque/plugins/job_stats']
  gem 'resque-cleaner', require: 'resque-cleaner'
  # gem 'resque-ensure-connected' # undefined method `verify_active_connections!' on an instance of ActiveRecord::ConnectionAdapters::ConnectionHandler
  gem 'resqued'
  # gem 'resque-pool'
  gem 'resque-lock-timeout'
  gem 'resque-async-method-enhanced'

  gem 'newrelic_rpm'
  # gem 'airbrake'
  # gem 'exception_notification', '>= 4.0.1' # deprecated for airbrake.io
  # gem "exception_logger", '>= 0.1.11' # currently incompatible w/ 3.1 :(
  gem 'rubinius-rails_logger'

  gem 'rack-cache'
  gem 'rack-tor-tag'#, '>= 0.1'
  gem 'rack-attack'

  gem 'mysql2' #, '~> 0.3.13' # currently required by ActiveRecord; see https://github.com/rails/rails/issues/21544
  gem 'json'#, '>= 1.6.6'

  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '>= 2.0'

  # Use ActiveModel has_secure_password
  gem 'bcrypt', '>= 3.1.7'

  # Use unicorn as the web server
  # gem 'unicorn'

  group :development do
    # Use Capistrano for deployment
    gem 'capistrano', require: false#, '>= 3.0.1'
    gem 'capistrano-rails', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano-rvm', require: false
    # gem 'capistrano-puma', require: false # use service instead

    gem 'capistrano-ci'
    gem 'term-ansicolor'
    platform(:mri) do # Ruby 2.0+ required.
      # Call 'byebug' anywhere in the code to stop execution and get a debugger console
      gem 'byebug'
      gem 'pry-byebug'
    end
    platform(:rbx) do
      gem 'rubinius-compiler'
      gem 'rubinius-debugger'
      gem 'rubinius-profiler'
    end

    gem 'pry'
    gem 'pry-rails'
    gem 'pry-doc'
    gem 'pry-git'
    gem 'awesome_print'

    gem 'pry-rescue'
    gem 'pry-stack_explorer'

    # Access an IRB console on exception pages or by using <%= console %> in views
    # gem 'web-console', '>= 2.0'
    gem "better_errors"
    gem "binding_of_caller"
  end

  # Bundle gems for the local environment. Make sure to
  # put test-only gems in this group so their generators
  # and rake tasks are available in development mode:
  group :development, :test do
    platform(:mri) {
      gem 'ruby-prof'
      # rubinius doesn't support ripper. https://github.com/rubinius/rubinius/issues/2377
      gem 'rails_best_practices'
    }
    gem 'webrat'#, '>= 0.7.3'
    gem "brakeman", '>= 3.0.2', require: false  # Rails security scanner
    gem 'rubocop', require: false
    gem 'bundler-audit', require: false
    gem 'rspec-rails'#, '~> 3.0.0.beta'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
  end

  group :test do
    gem 'codeclimate-test-reporter', require: nil
    gem 'cucumber-rails', :require => false
    gem 'database_cleaner'
  end

  # Bundle the extra gems:
  # gem 'bj'
  gem 'nokogiri', '>= 1.6.8' # >1.6.8 required to fix CVE-2015-8806 et al
  # gem 'sqlite3-ruby', :require => 'sqlite3'
  # gem 'aws-s3', :require => 'aws/s3'

  gem 'Empact-activerecord-import'#, '>= 0.4.1' # zdennis hasn't yet imported the import profiling fix; this is a bugfix tracking fork
  gem "paper_trail"#, '>= 3.0.0'

  gem 'paperclip'
  gem 'paperclip-meta'

  gem 'groupdate' # https://github.com/ankane/groupdate
  gem 'mailhopper' # https://github.com/cerebris/mailhopper
  gem 'mechanize'

  # NoMethodError: undefined method `[]' for #<ActiveRecord::Reflection::AssociationReflection:0x007fe9a2743860>
  # gem 'has_many_polymorphs', github => 'jystewart/has_many_polymorphs'

  # gem 'apotomo' # provides cells. not rails 4 compatible
  gem 'state_machine'

  gem 'fech', :require => 'fech'#, '>= 1.0.2'
#  gem 'activerecord-mysql-unsigned' # doesn't support AR 5.0

  gem 'money'#, '>= 5.0.0'
  # FIXME: pending monetize bump: https://github.com/RubyMoney/money-rails/pull/331
  gem 'money-rails'#, '>= 1.4.1'#, '>= 0.8.1'
  # gem 'monetize'
  gem 'activemerchant'
  gem 'offsite_payments'
  gem "active_paypal_adaptive_payment"

  gem 'stripe_event'

  gem 'jwt' # for Google Wallet

  gem 'amazon_flex_pay'

  # gem 'bitpay-rails', :require => 'bit_pay_rails'
  gem 'coinbase', ">= 2.2.1" #, github: 'coinbase/coinbase-ruby', branch: 'v3'
  gem 'em-http-request'
  # omniauth-coinbase depends on coinbase ~>2.0

  gem "devise"#, ">= 4.2.0"
  gem "devise-encryptable"#, ">= 0.1.1c"
  gem "omniauth"#, ">= 1.1.0"
  gem "omniauth-facebook"#, '>= 1.2.0'
  gem "omniauth-github"#, '>= 1.0.1'
  gem "omniauth-google-oauth2"#, '>= 0.1.9'
  gem "omniauth-openid"#, '>= 1.0.1'
  gem "omniauth-twitter"#, '>= 0.0.10'
  gem "omniauth-paypal"#, '>= 1.2.1'
  gem "omniauth-coinbase", '>= 1.0.2'

  # gem 'devise-async'

  gem 'cancancan' # original cancan went inactive
  # gem 'cantango', '>= 0.9.4.7'
  gem 'rolify'

  gem "rails_email_validator"#, '>= 0.1.4'
  gem "it"#, ">= 0.2.3"

  gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
  # required for uglifier:
  gem 'execjs'#, '>= 1.3.0' # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '>= 0.12.2', platforms: :ruby
  gem 'libv8' #, '>= 5.1.281.59.1' # only v3 supported in current TRR. https://github.com/cowboyd/therubyracer/pull/348

  gem 'coffee-rails', '>= 4.1.0' # Use CoffeeScript for .js.coffee assets and views
  gem 'sass-rails', '>= 5.0' # Use SCSS for stylesheets

  # Use jquery as the JavaScript library
  gem 'jquery-rails'#, '>= 3.0.0'
  gem 'jquery-ui-rails'#, '>= 5.0.0'
  gem 'jquery-turbolinks'
  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  gem 'turbolinks'

  # gem 'jquery_datepicker' # rails 4 incompatible 2013-06-29
  # gem 'bettertabs' # breaks in rails 5
  gem 'phone'

  gem 'kramdown'

  gem "strip_attributes"#, ">= 1.1.0"
  # gem 'client_side_validations' # rails 4 incompatible

  gem 'friendly_id'#, ">= 5.0.0"

  gem 'twitter'
  gem 'uncoil'
end
