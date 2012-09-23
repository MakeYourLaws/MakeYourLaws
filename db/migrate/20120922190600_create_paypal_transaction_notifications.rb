class CreatePaypalTransactionNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_transaction_notifications do |t|
      t.references :subtransaction
      t.boolean :legit # paypal acknowledged it
      t.boolean :test
      t.string :paypal_transaction_id, :null => false
      t.string :status, :limit => 20
      t.text :details_json
      
      t.timestamps
    end
    
    add_index :paypal_transaction_notifications, :subtransaction_id
    add_index :paypal_transaction_notifications, :paypal_transaction_id
    add_index :paypal_transaction_notifications, :status
    add_index :paypal_transaction_notifications, :legit
  end
end
