def CreateAmazonPayments < ActiveRecord::Migration
 def change
   create_table :amazon_payments do |t|
     # t.string :caller_reference, limit: 128 # use id.to_s instead
     t.string :transaction_id, limit: 35
     t.string :request_id
     t.string :status
   end
 end
end