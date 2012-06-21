class CreateFecCommittees < ActiveRecord::Migration
  def change
    create_table :fec_committees do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.string :name, :limit => 90, :null => false
      t.string :treasurer_name, :limit => 38
      t.string :street_1, :street_2, :limit => 34
      t.string :city, :limit => 18
      t.string :state, :limit => 2
      t.string :zip, :limit => 5
      t.string :designation, :type, :limit  => 1
      t.string :party, :limit => 3
      t.string :filing_frequency, :interest_group_category, :limit => 1
      t.string :connected_organization_name, :limit => 38
      t.string :candidate_id, :limit => 9
      
      t.integer :last_update_year
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    add_index :fec_committees, :fec_id, :unique => true
    add_index :fec_committees, :name
    add_index :fec_committees, :treasurer_name
    add_index :fec_committees, [:state, :city]
    add_index :fec_committees, :party
    add_index :fec_committees, :designation
    add_index :fec_committees, :interest_group_category
    add_index :fec_committees, :connected_organization_name
    add_index :fec_committees, :candidate_id
    add_index :fec_committees, :updated_at
  end
end
