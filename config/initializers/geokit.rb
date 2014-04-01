# These defaults are used in Geokit::Mappable.distance_to and in acts_as_mappable
Geokit::default_units = :miles
Geokit::default_formula = :sphere

# This is the timeout value in seconds to be used for calls to the geocoder web
# services.  For no timeout at all, comment out the setting.  The timeout unit
# is in seconds.
Geokit::Geocoders::request_timeout = 3

# This setting can be used if web service calls must be routed through a proxy.
# These setting can be nil if not needed, otherwise, a valid URI must be
# filled in at a minimum.  If the proxy requires authentication, the username
# and password can be provided as well.
# Geokit::Geocoders::proxy = 'https://user:password@host:port'


# This is your yahoo application key for the Yahoo Geocoder.
# See http://developer.yahoo.com/faq/index.html#appid
# and http://developer.yahoo.com/maps/rest/V1/geocode.html
# Geokit::Geocoders::yahoo.key = Keys.get('yahoo_geocoder_key')
# Geokit::Geocoders::yahoo.secret = Keys.get('yahoo_geocoder_secret')

# This is your Google Maps geocoder keys (all optional).
# See http://www.google.com/apis/maps/signup.html
# and http://www.google.com/apis/maps/documentation/#Geocoding_Examples
Geokit::Geocoders::GoogleGeocoder.client_id = Keys.get('google_id')
Geokit::Geocoders::GoogleGeocoder.cryptographic_key = Keys.get('google_secret')
# Geokit::Geocoders::GoogleGeocoder.channel = Keys.get('google_channel') # ?

# google do_geocode options: language, bias


# You can also set multiple API KEYS for different domains that may be directed to this same application.
# The domain from which the current user is being directed will automatically be updated for Geokit via
# the GeocoderControl class, which gets it's begin filter mixed into the ActionController.
# You define these keys with a Hash as follows:
# Geokit::Geocoders::google = { 'rubyonrails.org' => 'RUBY_ON_RAILS_API_KEY', 'ruby-docs.org' => 'RUBY_DOCS_API_KEY' }

# This is your username and password for geocoder.us.
# To use the free service, the value can be set to nil or false.  For
# usage tied to an account, the value should be set to username:password.
# See http://geocoder.us
# and http://geocoder.us/user/signup
Geokit::Geocoders::UsGeocoder.key = false # Keys.get('geocoder_us') # 'username:password'

# This is your authorization key for geocoder.ca.
# To use the free service, the value can be set to nil or false.  For
# usage tied to an account, set the value to the key obtained from
# Geocoder.ca.
# See http://geocoder.ca
# and http://geocoder.ca/?register=1
Geokit::Geocoders::CaGeocoder.key = Keys.get('geocoder_ca')


# Most other geocoders need either no setup or a key
# Geokit::Geocoders::BingGeocoder.key = Keys.get('bing_key')
# # Geokit::Geocoders::BingGeocoder.culture = ???
# Geokit::Geocoders::GeonamesGeocoder.key = Keys.get('geonames_username')
# Geokit::Geocoders::MapQuestGeocoder.key = Keys.get('mapquest_key')
# Geokit::Geocoders::YandexGeocoder.key = Keys.get('yandex_key')

# http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
Geokit::Geocoders::MaxmindGeocoder.geoip_data_path = 'db/data/' # path to GeoLiteCity.dat

# require "external_geocoder.rb"
# Please see the section "writing your own geocoders" for more information.
# Geokit::Geocoders::external_key = 'REPLACE_WITH_YOUR_API_KEY'

# This is the order in which the geocoders are called in a failover scenario
# If you only want to use a single geocoder, put a single symbol in the array.
# Be aware that there are Terms of Use restrictions on how you can use the
# various geocoders.  Make sure you read up on relevant Terms of Use for each
# geocoder you are going to use.


# Providers: :bing, :ca, :fcc, :free_geo_ip, :google, :map_quest, :maxmind, :o_s_m :google, :us, :yahoo, :yandex
Geokit::Geocoders::provider_order = [:google,:us]

# The IP provider order.
# As before, make sure you read up on relevant Terms of Use for each.

# Providers: :ip, :geo_plugin (= :ripe)
Geokit::Geocoders::ip_provider_order = [:geo_plugin,:ip]

# Disable HTTPS globally.  This option can also be set on individual
# geocoder classes.
# Geokit::Geocoders::secure = false  # default: true

# Control verification of the server certificate for geocoders using HTTPS
# Geokit::Geocoders::ssl_verify_mode = OpenSSL::SSL::VERIFY_NONE  # default: VERIFY_PEER
# Setting this to VERIFY_NONE may be needed on systems that don't have
# a complete or up to date root certificate store. Only applies to
# the Net::HTTP adapter.