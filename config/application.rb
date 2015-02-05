require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'activerecord-import' # doesn't auto-require properly

# patch for https://github.com/mikel/mail/pull/782 / https://github.com/rubinius/rubinius/issues/3050
module Mail
  class PartsList
    def sort_by args = nil
      p "custom sort_by - args: #{args.inspect}, self: #{self.inspect}"
      (self.empty? or args.blank?) ? self : super(args)
    end
  end
end


module MakeyourlawsOrg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += [Rails.root.join('lib'), Rails.root.join('lib', '{**}')]
    # Don't do this. See http://stackoverflow.com/questions/12467847/rails-namespaced-model-conflicting-with-non-namespaced-model
    # config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    config.middleware.insert_after ActionDispatch::RemoteIp, Rack::TorTag,
                                   host_ips: ['173.255.252.140']
    config.middleware.use Rack::Attack
    Rack::Attack.cache.store = Redis::Store.new(db: 5)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :en

    # Rails 4.2.0+. Current coinbase & bitpay not yet compatible.
    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # # Enforce whitelist mode for mass assignment.
    # # This will create an empty whitelist of attributes available for mass-assignment for all
    # # models in your app. As such, your models will need to explicitly whitelist or blacklist
    # # accessible parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true

    config.action_mailer.default_options = {
      from: 'MYL <notifications@makeyourlaws.org>'
    }

    config.cache_store = :redis_store, { db: 1 }

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end

# TODO: Expand once we start doing more than just US states
JURISDICTIONS = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
                 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois',
                 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',
                 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana',
                 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
                 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania',
                 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah',
                 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming',
                 'District of Columbia', 'Puerto Rico', 'Guam', 'American Samoa',
                 'U.S. Virgin Islands', 'Northern Mariana Islands']
