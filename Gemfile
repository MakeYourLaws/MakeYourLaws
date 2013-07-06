source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 4.0.0'
gem 'rake', '>= 0.9.2.2'
gem 'rack', '>= 1.4.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'dalli' # or Redis?

gem 'rack-cache'

gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

# Bundle edge Rails instead:
# gem 'rails', github: 'rails/rails'

gem 'mysql2', '>= 0.3.11'
gem 'json', '>= 1.6.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '>= 1.2'

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
# gem "paper_trail", '>= 2.6.3'
gem "paper_trail", github: 'airblade/paper_trail', branch: 'rails4'

# NoMethodError: undefined method `[]' for #<ActiveRecord::Reflection::AssociationReflection:0x007fe9a2743860>
# gem 'has_many_polymorphs', github => 'jystewart/has_many_polymorphs'

# gem 'apotomo' # provides cells. not rails 4 compatible
gem 'state_machine'

# use MYL's fork of NYT's Fech gem, since it has bugfixes and other features that NYT hasn't committed
gem 'myl-fech', '>= 1.0.2', :require => 'fech'

gem 'money', '>= 5.0.0'
gem 'money-rails'
gem "active_paypal_adaptive_payment"

gem 'stripe', github: 'stripe/stripe-ruby'
gem 'stripe_event'
gem 'jwt' # for Google Wallet

# gem "devise", ">= 2.0.4"
gem 'devise', '3.0.0.rc' # rails 4 version
gem "devise-encryptable", ">= 0.1.1c"
gem "omniauth", ">= 1.1.0"
gem "omniauth-facebook", '>= 1.2.0'
gem "omniauth-github", '>= 1.0.1'
gem "omniauth-google-oauth2", '>= 0.1.9'
gem "omniauth-openid", '>= 1.0.1'
gem "omniauth-twitter", '>= 0.0.10'
gem "omniauth-paypal", '>= 0.1.0', github: 'datariot/omniauth-paypal'

gem 'cancan', '>= 1.6.8'
# gem 'cantango', '>= 0.9.4.7'

gem "rails_email_validator", '>= 0.1.4'
gem "it", ">= 0.2.3"

# Gems used only for assets and not required
# in production environments by default.
gem 'execjs', '>= 1.3.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '>= 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'sass-rails', '>= 4.0.0' # Use SCSS for stylesheets

gem 'jquery-rails', '>= 2.0.2'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# gem 'jquery_datepicker' # rails 4 incompatible 2013-06-29
gem 'bettertabs'
gem 'phone', github: 'carr/phone'

gem 'rdiscount' # or maybe bluecloth? TBD

gem "strip_attributes", ">= 1.1.0"
# gem 'client_side_validations', ">= 3.1.4" # rails 4 incompatible
gem 'client_side_validations', github: 'bcardarella/client_side_validations', branch: '4-0-beta'
gem 'friendly_id'

# gem 'exception_notification', '>= 2.6.1', :require => 'exception_notifier'
gem 'exception_notification', '>= 4.0.0.rc1', github: 'smartinez87/exception_notification'

# gem "exception_logger", '>= 0.1.11' # currently incompatible w/ 3.1 :(
gem 'newrelic_rpm', ">= 3.4.0"

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'thin'
  gem 'ruby-prof'
  gem 'debugger'
  gem 'webrat', '>= 0.7.3'
end
