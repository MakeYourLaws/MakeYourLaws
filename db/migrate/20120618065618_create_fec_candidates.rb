class CreateFecCandidates < ActiveRecord::Migration
  def change
    create_table :fec_candidates do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.string :name, :limit => 38#, :null => false # S0ID00065 has null name
      t.string :party, :party_2, :limit => 3
      t.string :incumbent_challenger, :status, :limit => 1
      t.string :street_1, :street_2, :limit => 34
      t.string :city, :limit => 18
      t.string :state, :limit => 2
      t.string :zip, :limit => 5
      t.string :principal_campaign_committee, :limit => 9
      t.string :year, :district, :limit  => 2
      
      t.integer :last_update_year
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    add_index :fec_candidates, :fec_id, :unique => true
    add_index :fec_candidates, :name
    add_index :fec_candidates, :party
    add_index :fec_candidates, :party_2
    add_index :fec_candidates, [:state, :city]
    add_index :fec_candidates, :incumbent_challenger
    add_index :fec_candidates, :status
    add_index :fec_candidates, :principal_campaign_committee
    add_index :fec_candidates, :year
    add_index :fec_candidates, :district
    add_index :fec_candidates, :updated_at
  end
end