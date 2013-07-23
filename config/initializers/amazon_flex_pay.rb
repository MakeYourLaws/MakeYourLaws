AmazonFlexPay.access_key = Keys.get 'amazon_public'
AmazonFlexPay.secret_key = Keys.get 'amazon_secret'
AmazonFlexPay.go_live! if Rails.env.production?
