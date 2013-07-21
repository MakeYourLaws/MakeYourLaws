class Payments::Paypal::Preapproval < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  def details get_billing_address = true
    # :error_language = 'en_US'
    if preapproval_key
      response = PAYPAL.details_for_payment :pay_key => preapproval_key, :get_billing_address => true
    else
      raise "Can't get details without preapproval_key"
    end
  end 
  
  def cancel!
    # :error_language = 'en_US'
    if preapproval_key
      response = PAYPAL.details_for_payment :pay_key => preapproval_key
    else
      raise "Can't get details without preapproval_key"
    end
  end 
end
