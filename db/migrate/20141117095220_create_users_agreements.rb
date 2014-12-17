class CreateUsersAgreements < ActiveRecord::Migration
  def change
    create_table :users_agreements do |t|
      t.integer :user_id
      t.integer :agreement_id

      t.text :signature

      t.timestamps
    end
    add_index :users_agreements, :user_id
    add_index :users_agreements, :agreement_id
  end
end
