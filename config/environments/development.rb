MakeyourlawsOrg::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # enable caching in development but still update on page change
  config.action_view.cache_template_loading = false

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method = :mailhopper
  config.action_mailer.raise_delivery_errors = false
  config.after_initialize do
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # # Do not compress assets
  config.assets.compress = true # make assets faster when not working on them
  config.assets.digest = true
  config.serve_static_assets = true
  config.assets.compile = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false # turn off when not debugging it

  Paperclip.options[:command_path] = "/opt/local/bin/convert"
end
