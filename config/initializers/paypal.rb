config = YAML.load(ERB.new(File.read(Rails.root.join 'config', 'paypal_adaptive.yml')).result)[Rails.env].symbolize_keys!

PAYPAL =  ActiveMerchant::Billing::PaypalAdaptivePayment.new config

ActiveMerchant::Billing::Base.mode = (config[:test] ? :test : :production)