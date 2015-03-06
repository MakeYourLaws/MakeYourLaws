class CreateRolesAgreements < ActiveRecord::Migration
  def change
    create_table :roles_agreements do |t|
      t.string :agreement_name
      t.integer :role_id

      t.timestamps
    end
    add_index :roles_agreements, :agreement_name
    add_index :roles_agreements, :role_id
  end
end
