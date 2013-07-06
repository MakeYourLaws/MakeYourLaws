class CreateLegalIdentities < ActiveRecord::Migration
  def change
    create_table :legal_identities do |t|
      t.string :full_name
      t.string :name_prefix, :length => 10
      t.string :first_name, :length => 50
      t.string :middle_name, :length => 50
      t.string :last_name, :length => 50
      t.string :name_suffix, :length => 10 # Jr., Sr., I, II, etc
      
      t.integer :previous_names_count
      
      t.text :residence_address
      t.text :mailing_address
      
      t.date :birthdate 
      t.string :gender, :length => 1 # M, F, O, nil - no free text here, since those aren't legally defined/recognized
      t.string :party  # full name of party, minus the "Party" part
      
      t.string :employer # specials: "self" and nil (for unemployed)
      t.string :occupation # special: "unemployed", "retired", "homemaker"
      
      t.integer :ssn, :limit => 4 # bytes, i.e. max 2147483647
      
      t.string :citizenship, :limit => 1 # us (C)itizen, (G)reencard, nil
                                         # eventually we'll have to support other citizenships too but not yet
      
      t.integer :us_house_district
      t.integer :us_senate_district
      t.integer :us_congress_district # ?
      t.string :city, :length => 50
      t.string :county, :length => 50
      t.integer :ward
      t.integer :election_district
      t.integer :legislative_district
      t.integer :county_voter_id
      t.integer :state_voter_id
      t.string :source 
      t.date :source_date
      
      t.reference :duplicate_of # for misspellings and the like; set on the non-canonical entries
                                # also set for change of address, set on the stale entries
                                # could make this HAABTM vs addresses, but given the scales involved it's probably better this way
      # may need some way to represent couples or other multi-identity pseudorecords; again that might be HAABTM
      
      t.integer :lock_version
      t.timestamps
    end
    
    # This is not technically true; multiple people with the exact same name can live at the same address.
    # However, for the purposes of any kind of identification we can easily run, we can't distinguish them.
    # Therefore, we rule out this case and ensure at least some uniqueness. Might distinguish by SSN eg in the future.
    add_index :legal_identities, [:full_name, :address], :unique => true
    add_index :ssn, :unique => true
    
    add_index :legal_identities, :employer
    add_index :legal_identities, :occupation # use for autocomplete
    add_index :legal_identities, :citizenship
  end
  
  create_table :names do |t|
    t.references :legal_identity
    
    t.string :full_name
    t.string :name_prefix, :length => 10
    t.string :first_name, :length => 50
    t.string :middle_name, :length => 50
    t.string :last_name, :length => 50
    t.string :name_suffix, :length => 10 # Jr., Sr., I, II, etc
    
    t.date :last_used
    
    t.integer :lock_version
    t.timestamps
  end
  
end
