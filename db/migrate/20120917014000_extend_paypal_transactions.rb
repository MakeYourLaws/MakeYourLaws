class ExtendPaypalTransactions < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :correlation_id, :string
    add_column :paypal_transactions, :memo, :string
    
    add_index :paypal_transactions, :correlation_id
  end
end
