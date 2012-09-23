# This is for the PDT type IPN. It's what's triggered by the IPN setting in the paypal website, as opposed to the IPN callback set in the payment request itself.
# PDTs are more detail about a particular subtransaction, as opposed to the general IPN which is about the whole lump.
class Paypal::TransactionNotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  skip_before_filter :verify_authenticity_token # API call
  skip_authorization_check # can't use CanCan for this; authorized via IPN acknowledgement

  def create
    notify = ActiveMerchant::Billing::Integrations::PaypalAdaptivePayment::Notification.new(request.raw_post)
    
    @subtransaction = Paypal::Subtransaction.find_by_paypal_transaction_id(notify.params['txn_id']) || Paypal::Subtransaction.find_by_paypal_transaction_id(notify.params['parent_txn_id'])
    @transaction_notification = Paypal::TransactionNotification.new
    @transaction_notification.details_json = notify.params.to_json
    # e.g. {"transaction_subject":"","payment_date":"19:44:28 Sep 22, 2012 PDT","txn_type":"web_accept","last_name":"'","residence_country":"US","item_name":"","payment_gross":"0.01","mc_currency":"USD","business":"c4@makeyourlaws.org","payment_type":"instant","protection_eligibility":"Ineligible","verify_sign":"Aaose356mD-hOFG7cGBTPyJXSUZEAKKenwyTHVS.S9D85xpOKDcuVhSw","payer_status":"verified","tax":"0.00","payer_email":"pp@saizai.com","txn_id":"29N45201R1338663X","quantity":"0","receiver_email":"c4@makeyourlaws.org","first_name":"Sai","payer_id":"J64ZRFCZ2A4MC","receiver_id":"R9QPE87RRNTH6","item_number":"","payment_status":"Completed","payment_fee":"0.01","mc_fee":"0.01","mc_gross":"0.01","custom":"","charset":"windows-1252","notify_version":"3.7","ipn_track_id":"400b7cc842cc9"}
    
    # Keys: business charset custom first_name ipn_track_id item_name item_number last_name mc_currency mc_fee mc_gross notify_version payer_email payer_id payer_status payment_date payment_fee payment_gross payment_status payment_type protection_eligibility quantity receiver_email receiver_id residence_country tax transaction_subject txn_id txn_type verify_sign
    
    # REFUND:
    
    # {"transaction_subject"=>"", "payment_date"=>"20:13:08 Sep 22, 2012 PDT", "last_name"=>"'", "residence_country"=>"US", "item_name"=>"", "payment_gross"=>"-0.01", "mc_currency"=>"USD", "business"=>"c4@makeyourlaws.org", "payment_type"=>"instant", "protection_eligibility"=>"Ineligible", "verify_sign"=>"AqAmVQJQPLwZBKk.ZAC6JQQIL5k.ADv0ZRA2y7taI3RlzWD9hwJZo4M9", "payer_email"=>"pp@saizai.com", "txn_id"=>"2U754936YB448952A", "receiver_email"=>"c4@makeyourlaws.org", "first_name"=>"Sai", "parent_txn_id"=>"29N45201R1338663X", "payer_id"=>"J64ZRFCZ2A4MC", "receiver_id"=>"R9QPE87RRNTH6", "reason_code"=>"refund", "item_number"=>"", "handling_amount"=>"0.00", "payment_status"=>"Refunded", "payment_fee"=>"0.00", "mc_fee"=>"0.00", "shipping"=>"0.00", "mc_gross"=>"-0.01", "custom"=>"", "charset"=>"windows-1252", "notify_version"=>"3.7", "ipn_track_id"=>"1bd77971c91f3"}
    
    # Keys: business charset custom first_name handling_amount ipn_track_id item_name item_number last_name mc_currency mc_fee mc_gross notify_version parent_txn_id payer_email payer_id payment_date payment_fee payment_gross payment_status payment_type protection_eligibility reason_code receiver_email receiver_id residence_country shipping transaction_subject txn_id verify_sign
    
    @transaction_notification.paypal_transaction_id = notify.params['txn_id']
    @transaction_notification.subtransaction_id = @subtransaction.id if @subtransaction
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