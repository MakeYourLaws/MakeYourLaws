Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  # config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.public_file_server.enabled = false # ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Disabling Rails asset munging to hand it off to mod_pagespeed instead
  config.assets.compress = false # normally true

  # Compress JavaScripts and CSS.
  # config.assets.js_compressor = :uglifier # normally turned on
  # config.assets.css_compressor = :sass

  # -- end mod_pagespeed punting

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true # done in app controller instead, to make Tor onion address non-SSL

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  config.after_initialize do
    Rails.application.routes.default_url_options[:host] = 'www.makeyourlaws.org'
  end
  config.action_mailer.default_url_options = { host: 'www.makeyourlaws.org' }
  config.action_mailer.delivery_method = :mailhopper
  # defaults to -i -t. However, Mail::Sendmail actually puts recipients on the command line, so
  #  if -t gets them from the headers, it screws things up. Thus, no -t.
  # config.action_mailer.sendmail_settings = { arguments: '-i ' }

  config.action_mailer.smtp_settings = {
    :address => 'smtp-relay.gmail.com',
    :port => 587,
    :domain => 'makeyourlaws.org',
    :authentication => :login,
    :user_name => 'no-reply@makeyourlaws.org',
    :password => Keys.get("google_smtp_password"),
    :enable_starttls_auto => true
  }

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = true # changed from false
  config.action_mailer.perform_deliveries = true

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  Paperclip.options[:command_path] = "/usr/bin/"

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
