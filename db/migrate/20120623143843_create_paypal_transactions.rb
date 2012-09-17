class CreatePaypalTransactions < ActiveRecord::Migration
  def change
    create_table :paypal_transactions do |t|
      t.references :user
      t.string :source
      t.string :pay_key
      t.integer :amount, :null => false, :default => nil
      t.string :currency, :limit => 3, :null => false, :default => 'USD'
      t.string :status, :limit => 20
      t.text :details_json
      
      t.timestamps
    end
    
    add_index :paypal_transactions, :user_id
    add_index :paypal_transactions, [:currency, :amount]
    add_index :paypal_transactions, :status
    add_index :paypal_transactions, :source
  end
end