class Paypal::NotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  skip_before_filter :verify_authenticity_token # API call
  skip_authorization_check # can't use CanCan for this; authorized via IPN acknowledgement

  def create
    notify = ActiveMerchant::Billing::Integrations::PaypalAdaptivePayment::Notification.new(request.raw_post)
    
    @transaction = Paypal::Transaction.find_by_pay_key notify.params['pay_key']
    @notification = Paypal::Notification.new
    @notification.details_json = notify.params.to_json
    
    # Common keys: action_type cancel_url charset fees_payer ipn_notification_url log_default_shipping_address_in_transaction notify_version pay_key payment_request_date return_url reverse_all_parallel_payments_on_error sender_email status transaction_type verify_sign
    # - transaction[0].: amount id id_for_sender_txn is_primary_receiver paymentType pending_reason receiver status status_for_sender_txn
    
    # PAYMENT:
    # Unique keys: none
    # {"payment_request_date":"Sat Sep 22 19:44:01 PDT 2012","return_url":"https://makeyourlaws.org/paypal/transactions/12?status=completed","fees_payer":"EACHRECEIVER","ipn_notification_url":"https://makeyourlaws.org/paypal/notifications","sender_email":"pp@saizai.com","verify_sign":"AQU0e5vuZCvSg-XJploSa.sGUDlpAyVBaZjtPQB1WB2Jd-bQE1-nV.k6","transaction[0].id_for_sender_txn":"4N405536K55876036","transaction[0].receiver":"c4@makeyourlaws.org","cancel_url":"https://makeyourlaws.org/paypal/transactions/12?status=canceled","transaction[0].is_primary_receiver":"false","pay_key":"AP-70J1028575193360D","action_type":"PAY","transaction[0].id":"29N45201R1338663X","transaction[0].status":"Completed","transaction[0].paymentType":"SERVICE","transaction[0].status_for_sender_txn":"Completed","transaction[0].pending_reason":"NONE","transaction_type":"Adaptive Payment PAY","transaction[0].amount":"USD 0.01","status":"COMPLETED","log_default_shipping_address_in_transaction":"false","charset":"windows-1252","notify_version":"UNVERSIONED","reverse_all_parallel_payments_on_error":"true"}
    
    # REFUND:
    # Unique keys: reason_code 
    # - transaction[0].: refund_account_charged refund_amount refund_id
    # {"transaction[0].refund_id":"2U754936YB448952A","payment_request_date":"Sat Sep 22 19:44:01 PDT 2012","return_url":"https://makeyourlaws.org/paypal/transactions/12?status=completed","fees_payer":"EACHRECEIVER","ipn_notification_url":"https://makeyourlaws.org/paypal/notifications","sender_email":"pp@saizai.com","verify_sign":"AiPC9BjkCyDFQXbSkoZcgqH3hpacA5OsOg7ZrAz83zcWVeiUPjmib1Gg","transaction[0].id_for_sender_txn":"4N405536K55876036","transaction[0].receiver":"c4@makeyourlaws.org","cancel_url":"https://makeyourlaws.org/paypal/transactions/12?status=canceled","transaction[0].is_primary_receiver":"false","reason_code":"Refund","pay_key":"AP-70J1028575193360D","action_type":"PAY","transaction[0].id":"29N45201R1338663X","transaction[0].refund_account_charged":"c4@makeyourlaws.org","transaction[0].refund_amount":"USD 0.01","transaction[0].status":"Refunded","transaction[0].paymentType":"SERVICE","transaction[0].status_for_sender_txn":"Refunded","transaction[0].pending_reason":"NONE","transaction_type":"Adjustment","transaction[0].amount":"USD 0.01","status":"COMPLETED","log_default_shipping_address_in_transaction":"false","charset":"windows-1252","notify_version":"UNVERSIONED","reverse_all_parallel_payments_on_error":"true"}
    
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