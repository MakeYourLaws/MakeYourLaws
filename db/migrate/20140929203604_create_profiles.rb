class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :handle, null: false
      t.string :handle_lowercase, null: false
      t.string :name, null: false
      t.text :bio
      t.string :type, null: false # recipient, proxy
      t.references :legal_identity # necessary only for recipients (not proxies)

      t.attachment :avatar
      t.text :avatar_meta
      t.string :avatar_fingerprint

      t.index :handle_lowercase, unique: true
      t.index :name
      t.index :legal_identity_id
    end

    remove_column :users, :login, :string
  end
end
