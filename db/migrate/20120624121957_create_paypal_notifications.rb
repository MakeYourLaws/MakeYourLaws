class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.references :transaction
      t.boolean :legit # paypal acknowledged it
      t.boolean :test
      t.string :pay_key
      t.string :status, :limit => 20
      t.text :details_json
      
      t.timestamps
    end
    
    add_index :paypal_notifications, :transaction_id
    add_index :paypal_notifications, :pay_key
    add_index :paypal_notifications, :status
    add_index :paypal_notifications, :legit
  end
end
