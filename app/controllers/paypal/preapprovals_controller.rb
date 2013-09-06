class Payments::Paypal::PreapprovalsController < ApplicationController
  load_and_authorize_resource :class => Payments::Paypal::Preapproval
  include ActiveMerchant::Billing::Integrations
  
  def create
  # :cancel_url, :return_url # required
  # :notify_url
  # :currency_code => "USD", :start_date => DateTime.current, :error_language => 'en_US'
  # :senderEmail
  # :end_date, :max_amount # required
  # :maxAmountPerPayment, :memo, :maxNumberOfPayments, :displayMaxTotalAmount,
  
  # preapprove_payment
  
  end
  
  def update # ipn
  end
  
  private
  
  def urls 
    {:return_url => completed_paypal_url,
    :cancel_url => canceled_paypal_url,
    :notify_url => paypal_preapproval_url(@preapproval),
    }
  end
end