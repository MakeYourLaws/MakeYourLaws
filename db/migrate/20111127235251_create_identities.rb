class CreateIdentities < ActiveRecord::Migration
  def change
    # These are for OmniAuth identities, schema version 1.0
    # See https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    create_table :identities do |t|
      t.references :user
      
      t.string :provider, :uid, :null => false
      t.string :name #, :null => false # Supposedly this is required per Devise, but LJ doesn't provide it.
      t.string :email, :nickname, :first_name, :last_name, :location
      t.text :description # aka "about me" profile text
      t.string :image # URL
      t.string :phone
      t.text :urls      # JSON hash
      t.string :token, :secret # for OAuth requests
      t.text :raw_info  # might be anything, should mainly be JSON or the like
      
      t.integer :lock_version, :default => 0
      
      t.timestamps
    end
    
    add_index :identities, :user_id
    add_index :identities, [:provider, :uid], :unique => true
    add_index :identities, :name
    add_index :identities, :email
    add_index :identities, :nickname
  end
end
