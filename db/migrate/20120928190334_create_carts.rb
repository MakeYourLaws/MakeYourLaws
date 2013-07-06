class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :user, :disbursement
      t.string :state
      
      t.integer :cart_items_count, :default => 0
      t.integer :total_cents # set by user, determines respective amount of items
      t.integer :currency
      
      t.integer :lock_version
      t.timestamps
    end
    
    add_index :carts, :user_id
    
    create_table :cart_items do |t|
      t.references :cart, :null => false
      t.references :committee, :null => false
      
      t.integer :amount_cents
      t.float :proportion # 0..1, proportion of cart total to be spent on this item
    end
    
    add_index :cart_items, [:cart_id, :committee_id], :unique => true
  end
end
