class Paypal::NotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  skip_before_filter :verify_authenticity_token # API call
  skip_authorization_check # can't use CanCan for this; authorized via IPN acknowledgement

  def create
    notify = ActiveMerchant::Billing::Integrations::PaypalAdaptivePayment::Notification.new(request.raw_post)
    @transaction = Paypal::Transaction.find_by_pay_key notify.params['pay_key']
    @notification = Paypal::Notification.new
    @notification.details_json = notify.params.to_json
    # e.g. {"payment_request_date"=>"Sun Jun 24 06:12:20 PDT 2012", "return_url"=>"http://saizai.dyndns.org/paypal/transactions/3?status=completed", "fees_payer"=>"EACHRECEIVER", "ipn_notification_url"=>"http://saizai.dyndns.org/paypal/notifications", "sender_email"=>"buyv_1340292806_per@saizai.com", "verify_sign"=>"AFcWxV21C7fd0v3bYYYRCpSSRl31AJJ3eM9I-0viuZHzN62F5l-KZMsZ", "test_ipn"=>"1", "transaction[0].id_for_sender_txn"=>"62C63301X13450007", "transaction[0].receiver"=>"myl_1340293142_biz@saizai.com", "cancel_url"=>"http://saizai.dyndns.org/paypal/transactions/3?status=canceled", "transaction[0].is_primary_receiver"=>"false", "pay_key"=>"AP-2UA41943VP417833G", "action_type"=>"PAY", "transaction[0].id"=>"7FU63628F0668361C", "transaction[0].status"=>"Completed", "transaction[0].paymentType"=>"SERVICE", "transaction[0].status_for_sender_txn"=>"Completed", "transaction[0].pending_reason"=>"NONE", "transaction_type"=>"Adaptive Payment PAY", "tracking_id"=>"3", "transaction[0].amount"=>"USD 1.00", "status"=>"COMPLETED", "log_default_shipping_address_in_transaction"=>"false", "charset"=>"windows-1252", "notify_version"=>"UNVERSIONED", "reverse_all_parallel_payments_on_error"=>"true"}     
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