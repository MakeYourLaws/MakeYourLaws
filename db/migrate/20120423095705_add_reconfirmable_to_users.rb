class AddReconfirmableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_email, :string
    
    add_index  :users, :unconfirmed_email, :unique => true
  end
  
end
