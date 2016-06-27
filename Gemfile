source 'https://code.stripe.com' do

  gem 'stripe'

end

source 'https://rubygems.org' do

  platform(:rbx) do
    gem 'rubysl'
    gem 'ffi'
    gem 'psych'
  end

  gem 'puma'

  gem 'rails', '>= 4.2.1' #, '>= 4.0.1'
  gem 'rake'#, '>= 0.9.2.2'
  gem 'rack'#, '>= 1.4.1'

  gem "better_errors"
  gem "binding_of_caller"

  gem 'foreigner' # remove on upgrade to rails 4.2.0
  gem 'immigrant'
  gem 'consistency_fail'
  gem 'sprockets'

  group :doc do
    # bundle exec rake doc:rails generates the API under doc/api.
    gem 'sdoc', require: false
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

  gem 'redis-rails' # switching out for dalli/memcached
  gem "redis-rack-cache"
  gem 'redis-session-store'

  gem "resque", require: "resque/server"
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
  gem 'jbuilder'#, '>= 1.2' # JSON APIs. https://github.com/rails/jbuilder

  gem 'bcrypt'#, '>= 3.0.1' # To use ActiveModel has_secure_password

  # Use unicorn as the web server
  # gem 'unicorn'

  group :development do
    gem 'capistrano', require: false#, '>= 3.0.1'
    gem 'capistrano-rails', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano-rvm', require: false
    # gem 'capistrano-puma', require: false # use service instead

    gem 'capistrano-ci'
    gem 'term-ansicolor'
    platform(:mri) do # Ruby 2.0+ required.
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
  gem 'activerecord-mysql-unsigned'

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

  gem "devise"#, ">= 3.1.1"
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

  # gem 'execjs'#, '>= 1.3.0' # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier'#, '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
  gem 'coffee-rails'#, '>= 4.0.0' # Use CoffeeScript for .js.coffee assets and views
  gem 'sass-rails'#, '>= 4.0.0' # Use SCSS for stylesheets

  gem 'jquery-rails'#, '>= 3.0.0'
  gem 'jquery-ui-rails'#, '>= 5.0.0'
  gem 'jquery-turbolinks'
  gem 'turbolinks' # makes links load faster; see https://github.com/rails/turbolinks

  # gem 'jquery_datepicker' # rails 4 incompatible 2013-06-29
  gem 'bettertabs'
  gem 'phone'

  gem 'kramdown'

  gem "strip_attributes"#, ">= 1.1.0"
  # gem 'client_side_validations' # rails 4 incompatible

  gem 'friendly_id'#, ">= 5.0.0"

  gem 'twitter'
  gem 'uncoil'
end
