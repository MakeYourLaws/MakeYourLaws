class Paypal::TransactionNotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  skip_before_filter :verify_authenticity_token # API call
  skip_authorization_check # can't use CanCan for this; authorized via IPN acknowledgement

  def create
    notify = ActiveMerchant::Billing::Integrations::PaypalAdaptivePayment::Notification.new(request.raw_post)
    
    @subtransaction = Paypal::Transaction.find_by_paypal_transaction_id notify.params['txn_id']
    @transaction_notification = Paypal::TransactionNotification.new
    @transaction_notification.details_json = notify.params.to_json
    # e.g. {"transaction_subject":"","payment_date":"18:17:32 Sep 22, 2012 PDT","txn_type":"web_accept","last_name":"'","residence_country":"US","item_name":"","payment_gross":"1.00","mc_currency":"USD","business":"c4@makeyourlaws.org","payment_type":"instant","protection_eligibility":"Ineligible","verify_sign":"Ap7A90.xtS8ZY0PiomkCG1dgf9S3A7JBMDRpbIh2W2wFY24itIdwQdrs","payer_status":"verified","tax":"0.00","payer_email":"pp@saizai.com","txn_id":"8CF8425087487523J","quantity":"0","receiver_email":"c4@makeyourlaws.org","first_name":"Sai","payer_id":"J64ZRFCZ2A4MC","receiver_id":"R9QPE87RRNTH6","item_number":"","payment_status":"Completed","payment_fee":"0.33","mc_fee":"0.33","mc_gross":"1.00","custom":"","charset":"windows-1252","notify_version":"3.7","ipn_track_id":"e03a84c4457c0"}
    
    # Keys: business charset custom first_name ipn_track_id item_name item_number last_name mc_currency mc_fee mc_gross notify_version payer_email payer_id payer_status payment_date payment_fee payment_gross payment_status payment_type protection_eligibility quantity receiver_email receiver_id residence_country tax transaction_subject txn_id txn_type verify_sign
    
    @transaction_notification.paypal_transaction_id = notify.params['txn_id']
    @transaction_notification.subtransaction_id = @subtransaction.id # notify.params['tracking_id']
    @transaction_notification.status = notify.params['payment_status']
    
    begin
      if notify.acknowledge
        # also available: test?, account, amount, item_id, type, transaction_id
        @transaction_notification.legit = true
        @transaction_notification.test = notify.test?
        @subtransaction.transaction.update_details! if @subtransaction
      else
        @transaction_notification.legit = false
        logger.error "POSSIBLE FORGERY ATTEMPT: PayPal denied validity of notification"
      end
    rescue => e
      @transaction_notification.status = 'ERROR'
      raise
    ensure
      @transaction_notification.save
    end

    head 200
  end
end