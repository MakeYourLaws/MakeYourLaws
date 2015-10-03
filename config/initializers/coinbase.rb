require 'coinbase/wallet'
require 'em-http'

if Rails.env.production?
  COINBASE = Coinbase::Wallet::AsyncClient.new(api_key: Keys.get('coinbase_key_pac'), api_secret: Keys.get('coinbase_secret_pac')))
else
  COINBASE = Coinbase::Wallet::AsyncClient.new(api_key: Keys.get('coinbase_key_pac'), api_secret: Keys.get('coinbase_secret_pac')), api_url: "https://api.sandbox.coinbase.com")
end