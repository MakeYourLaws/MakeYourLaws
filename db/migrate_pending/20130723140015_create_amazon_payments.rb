def CreateAmazonPayments < ActiveRecord::Migration
 def change
   create_table :amazon_payments do |t|
     # t.string :caller_reference, limit: 128 # use id.to_s instead
     t.string :transaction_id, limit: 35
     t.string :request_id
     t.string :status
   end
   
   create_table :amazon_notifications do |t|
     # Common
     t.string :address_full_name
     t.string :address_line_1, :address_line_2, :address_state, :address_zip, :address_country
     t.string :address_phone
     t.string :buyer_email, limit: 65 # only returned if recipient == caller
     t.string :buyer_name, limit: 128
     t.string :certificate_url, limit: 1024
     t.string :customer_email, limit: 65
     t.string :customer_name, limit: 128
     t.string :date_installed, limit: 30 # if notification_type is 'TokenCancellation'; format: '2009-10-07T04:29:05.054-07:00'
     t.string :is_shipping_address_provided # 'TRUE' or nil
     t.string :operation, limit: 20 # e.g. PAY
     t.string :notification_type, limit: 20 # TokenCancellation or TransactionStatus
     t.string :payment_method, limit: 20 # ABT, ACH, CC
     t.string :payment_reason
     t.string :recipient_email, limit: 65 # check that this is the same as in original request
     t.string :recipient_name, limit: 128
     t.string :signature, limit: 512 
     t.integer :signature_version, limit: 1 # bytes, 127; valid values: 1, 2
     t.string :signature_method, limit: 10 # HmacSHA256 (preferred), HmacSHA1 # UNDOCUMENTED: RSA-SHA1
     t.string :token_id, limit: 65 # ID of cancelled token if notification_type == TokenCancellation
     t.string :token_type, limit: 20 # type of cancelled token if ditto
     t.string :transaction_amount, limit: 30 # e.g. 'USD 1.00'. Yes seriously.
     t.datetime :transaction_date # , limit: 40 # API docs say '40 bytes' of type Long. Epoch seconds.
     t.string :transaction_id, limit: 35
     t.string :transaction_status # CANCELLED, ...
     
     # Marketplace specific (?)
     t.string :reference_id
     t.string :status
     
     # http://docs.aws.amazon.com/AmazonFPS/latest/FPSAdvancedGuide/Cancel.html
     # http://docs.aws.amazon.com/AmazonFPS/latest/FPSAdvancedGuide/GetTransactionStatus.html
     t.string :status_code # Canceled, Expired, PendingNetworkResponse, PendingVerification, Success, TransactionDenied
   end
   
   create_table :tokens do |t|
     t.string :caller_reference
     t.string :date_installed # e.g. '2009-10-07T04:29:05.054-07:00'
     t.string :friendly_name
     t.string :old_token_id
     t.string :payment_reason
     t.string :token_id
     t.string :token_status # %w(Active Inactive)
     t.string :token_type # %w(MultiUse Recurring SingleUse Unrestricted)
   end
 end
end