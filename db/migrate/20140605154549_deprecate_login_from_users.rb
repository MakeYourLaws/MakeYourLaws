class DeprecateLoginFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, :login # have to drop and add to remove uniqueness
    add_index :users, :login # temporary pending move to profiles

    change_column :users, :email, :string, default: nil, null: false
    change_column :users, :login, :string, default: nil, null: true
  end
end
