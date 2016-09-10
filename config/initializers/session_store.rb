# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :encrypted_cookie_store,
#  :key => '_makeyourlaws.org_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Rails.application.config.session_store :redis_store, servers: { db: 2 }, expires_in: 1.day
