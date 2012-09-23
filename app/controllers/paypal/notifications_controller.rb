class Paypal::NotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  skip_before_filter :verify_authenticity_token # API call
  skip_authorization_check # can't use CanCan for this; authorized via IPN acknowledgement

  def create
    notify = ActiveMerchant::Billing::Integrations::PaypalAdaptivePayment::Notification.new(request.raw_post)
    

    
    @transaction = Paypal::Transaction.find_by_pay_key notify.params['pay_key']
    @notification = Paypal::Notification.new
    @notification.details_json = notify.params.to_json
    # {"payment_request_date":"Sat Sep 22 18:17:07 PDT 2012","return_url":"https://makeyourlaws.org/paypal/transactions/3?status=completed","fees_payer":"EACHRECEIVER","ipn_notification_url":"https://makeyourlaws.org/paypal/notifications","sender_email":"pp@saizai.com","verify_sign":"AGu.hbwMxRXoqDiyy-IJNOnULnvNA.sKj54B87.C61fADapvAm.AJsQ-","transaction[0].id_for_sender_txn":"6NT32377GL259751R","transaction[0].receiver":"c4@makeyourlaws.org","cancel_url":"https://makeyourlaws.org/paypal/transactions/3?status=canceled","transaction[0].is_primary_receiver":"false","pay_key":"AP-78W663870K9430616","action_type":"PAY","transaction[0].id":"8CF8425087487523J","transaction[0].status":"Completed","transaction[0].paymentType":"SERVICE","transaction[0].status_for_sender_txn":"Completed","transaction[0].pending_reason":"NONE","transaction_type":"Adaptive Payment PAY","transaction[0].amount":"USD 1.00","status":"COMPLETED","log_default_shipping_address_in_transaction":"false","charset":"windows-1252","notify_version":"UNVERSIONED","reverse_all_parallel_payments_on_error":"true"}
    
    # Keys: action_type cancel_url charset fees_payer ipn_notification_url log_default_shipping_address_in_transaction notify_version pay_key payment_request_date return_url reverse_all_parallel_payments_on_error sender_email status transaction[0].amount transaction[0].id transaction[0].id_for_sender_txn transaction[0].is_primary_receiver transaction[0].paymentType transaction[0].pending_reason transaction[0].receiver transaction[0].status transaction[0].status_for_sender_txn transaction_type verify_sign
    
    @notification.pay_key = notify.params['pay_key']
    @notification.transaction_id = @transaction.id # notify.params['tracking_id']
    @notification.status = notify.status
    
    begin
      if notify.acknowledge
        # also available: test?, account, amount, item_id, type, transaction_id
        @notification.legit = true
        @notification.test = notify.test?
        @transaction.update_details! if @transaction
      else
        @notification.legit = false
        logger.error "POSSIBLE FORGERY ATTEMPT: PayPal denied validity of notification"
      end
    rescue => e
      @notification.status = 'ERROR'
      raise
    ensure
      @notification.save
    end

    head 200
  end
end