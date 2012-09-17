class CreatePaypalSubtransactions < ActiveRecord::Migration
  def change
    create_table :paypal_subtransactions do |t|
      t.references :user
      t.references :transaction, :null => false
      t.string :paypal_transaction_id
      t.string :sender_transaction_id
      t.string :receiver
      t.integer :amount_cents, :null => false, :default => nil
      t.string :currency, :limit => 3, :null => false, :default => 'USD'
      t.string :status, :limit => 20
      t.string :sender_status, :limit => 20
      t.integer :refunded_amount_cents
      t.boolean :pending_refund
      
      t.timestamps
    end
    
    add_index :paypal_subtransactions, :user_id
    add_index :paypal_subtransactions, :paypal_transaction_id
    add_index :paypal_subtransactions, :transaction_id
    add_index :paypal_subtransactions, :sender_transaction_id
    add_index :paypal_subtransactions, :receiver
    add_index :paypal_subtransactions, [:currency, :amount_cents]
    add_index :paypal_subtransactions, :status
    add_index :paypal_subtransactions, :sender_status
    add_index :paypal_subtransactions, :pending_refund
  end
end
