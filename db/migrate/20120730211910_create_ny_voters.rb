class CreateNyVoters < ActiveRecord::Migration
  def change
    create_table :ny_voters do |t|
      t.string :last_name, :length => 50
      t.string :first_name, :length => 50
      t.string :middle_name, :length => 50
      t.string :name_suffix, :length => 10
      t.string :residence_house_number, :length => 10
      t.string :residence_fractional_number, :length => 10
      t.string :residence_apartment, :length => 15
      t.string :residence_pre_street_direction, :length => 10
      t.string :residence_street_name, :length => 70
      t.string :residence_post_street_direction, :length => 10
      t.string :residence_city, :length => 50
      t.string :residence_zip5, :length => 5
      t.string :residence_zip4, :length => 4
      t.string :mailing_address_1, :length => 100
      t.string :mailing_address_2, :length => 100
      t.string :mailing_address_3, :length => 100
      t.string :mailing_address_4, :length => 100
      t.string :dob, :length => 8 # dates intentionally kept as strings, to ensure that any partial dates are represented as original
      t.string :gender, :length => 1
      t.string :enrollment, :length => 3
      t.string :other_party, :length => 30
      t.integer :county_code, :length => 1 # 2 digits, 1 byte - max 127
      t.integer :election_district, :length => 2 # 3 digits, 2 bytes - max 32767
      t.integer :legislative_district, :length => 2 # bytes
      t.string :town_city, :length => 30
      t.string :ward, :length => 3
      t.integer :congressional_district, :length => 2 # bytes
      t.integer :senate_district, :length => 2 # bytes
      t.integer :assembly_district, :length => 2 # bytes
      t.string :last_date_voted, :length => 8
      t.string :last_year_voted, :length => 4
      t.string :last_county_voted, :length => 2
      t.string :last_registered_address, :length => 100
      t.string :last_registered_name, :length => 100
      t.string :county_voter_registration_number, :length => 50
      t.string :application_date, :length => 8
      t.string :application_source, :length => 10
      t.string :id_required, :length => 1
      t.string :id_verification_met, :length => 1
      t.string :status, :length => 10
      t.string :reason, :length => 15
      t.string :inactive_date, :length => 8
      t.string :purged_date, :length => 8
      t.string :voter_id, :length => 50
      t.text :voter_history
      
      t.integer :lock_version
      t.timestamps
    end
  
    add_index :ny_voters, :voter_id, :unique => true
    add_index :ny_voters, [:last_name, :first_name]
    add_index :ny_voters, :first_name
    add_index :ny_voters, [:residence_zip5, :residence_zip4]
    add_index :ny_voters, :residence_city
    add_index :ny_voters, :dob
    add_index :ny_voters, [:enrollment, :other_party]
    add_index :ny_voters, :county_code
    add_index :ny_voters, :election_district
    add_index :ny_voters, :legislative_district
    add_index :ny_voters, :town_city
    add_index :ny_voters, :ward
    add_index :ny_voters, :congressional_district
    add_index :ny_voters, :senate_district
    add_index :ny_voters, :assembly_district
    add_index :ny_voters, :county_voter_registration_number
    add_index :ny_voters, [:status, :reason]
  end
end
