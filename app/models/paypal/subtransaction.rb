class Paypal::Subtransaction < ActiveRecord::Base
  self.table_name = "paypal_subtransactions" # use namespaced table
  include Rails.application.routes.url_helpers
  has_paper_trail
  
  belongs_to :transaction
  belongs_to :user
  
  monetize :amount_cents
  
  STATUSES = %W( CREATED COMPLETED INCOMPLETE ERROR REVERSALERROR PROCESSING PENDING ) # TODO: check actual statuses for subs
  
  # assumes transaction_id, paypal_transaction_id, and user_id are set already
  def set_from_hash hash
    #  {"transactionId":"7GH50140BN703313B","transactionStatus":"COMPLETED","receiver":{"amount":"10.50","email":"myla_1340554564_biz@saizai.com","primary":"false","paymentType":"SERVICE"},"refundedAmount":"0.00","pendingRefund":"false","senderTransactionId":"0EK05781E1952545M","senderTransactionStatus":"COMPLETED"}]},
    self.sender_transaction_id = hash['senderTransactionId']
    self.receiver = hash['receiver']['email']
    self.amount_cents = hash['receiver']['amount'].to_d*100 rescue 0 # TODO: get currency from parent
    self.status = hash['transactionStatus']
    self.sender_status = hash['senderTransactionStatus']
    self.refunded_amount_cents = hash['refundedAmount'].to_d*100 rescue 0
    self.pending_refund = case hash['pendingRefund']
      when 'false' then false
      when 'true' then true
      else raise "Unknown pendingRefund value"
    end
    self
  end
end