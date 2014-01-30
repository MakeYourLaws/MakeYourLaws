class CreateBitPayTables < ActiveRecord::Migration
  def change
    create_table :bit_pay_invoices do |t|
      t.string :bitpay_id
      t.string :url
      t.string :pos_data, limit: 100
      
      
      # new, paid, confirmed, complete, expired, invalid
      t.string :state, limit: 10, null: false, default: 'new' 
      t.decimal :price, null: false
      t.string :currency, limit: 3, null: false # USD, EUR, BTC, etc.
      # https://bitpay.com/bitcoin­exchange­rates for full list
      
      # info for buyer display purposes only
      t.string :order_id, limit: 100
      t.string :item_desc, limit: 100
      t.string :item_code, limit: 100
      t.boolean :physical, default: false, null: false
      t.string :buyer_name, :buyer_address_1, :buyer_address_2, :buyer_city, 
        :buyer_state, :buyer_zip, :buyer_country, :buyer_email, :buyer_phone, limit: 100
      
      # added by bitpay
      t.decimal :btc_price
      t.datetime :invoice_time
      t.datetime :expiration_time # default 15 minutes from creation
      t.datetime :current_time # on BitPay
      
    end
    
    create_table :bit_pay_rates do |t|
      t.string :name
      t.string :code, limit: 3
      t.decimal :rate
    end
  end
end
