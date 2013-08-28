class CreateSsnDeathRecords < ActiveRecord::Migration
  # Format spec: http://ssdmf.info/blah-blah-blah.pdf
  
  def change
    create_table :ssn_death_records do |t|
      t.string :change_type, limit: 1 # Add, Change, Delete
      t.integer :ssn # 9 digits
      t.string :last_name, limit: 20
      t.string :name_suffix, limit: 4
      t.string :first_name, limit: 15
      t.string :middle_name, limit: 15
      t.string :verified, limit: 1 # Verified, Proof
      t.date :death_date, :birth_date
      t.boolean :death_date_noday, :death_date_badleap, :birth_date_noday, :birth_date_badleap
      t.integer :age_in_days
    end
    
    add_index :ssn_death_records, :ssn
    add_index :ssn_death_records, [:first_name, :change_type]
    add_index :ssn_death_records, [:last_name, :first_name, :change_type], :name => "last_first"
    add_index :ssn_death_records, [:death_date, :change_type]
    add_index :ssn_death_records, [:birth_date, :death_date, :change_type], :name => "birth_death"
  end
end
