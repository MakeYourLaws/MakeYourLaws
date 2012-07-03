class AllowNullPasswordsOnUsers < ActiveRecord::Migration
  def up
    # password can be nil if user has identities
    change_column :users, :encrypted_password, :string, :null => true
  end

  def down
    change_column :users, :encrypted_password, :string, :null => false
  end
end
