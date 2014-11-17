class CreateLegalIdentities < ActiveRecord::Migration
  def change
    create_table :legal_identities do |t|
      t.boolean :human, :null => false

      # Both humans and corporations
      t.date :birthdate # i.e. 'incorporation date' for corps

      # This is actually 1:M not 1:1 (EIN/SSN/etc can be changed), but for now we're not handling that
      t.integer :irs_id, :limit => 4 #  bytes — EIN for corps, SSN for humans
      t.boolean :govt_contractor

      # t.integer :party_id # refers to an FEC::Committee ID this entity is formally affiliated with (if any)

      # Human specific
      t.boolean :us_citizen_or_greencard # US Citizen or permanent resident / green card holder?

      t.integer :lock_version
      t.timestamps

      t.index :irs_id, :unique => true # allows nil in most DBs, incl mysql
    end

    # Doesn't belong exclusively to any individual (people share the same name)
    # Also, this is *legal* names (as in what's on wallet ID) - not the same as display names.
    create_table :legal_names do |t|
      t.string :full_name
      t.string :name_prefix, :length => 10 # Based on FEC filing requirements
      t.string :first_name, :length => 50
      t.string :middle_name, :length => 50
      t.string :last_name, :length => 50
      t.string :name_suffix, :length => 10 # Jr., Sr., I, II, etc

      t.index :full_name
      t.index [:last_name, :first_name]
    end

    create_table :occupations do |t|
      t.string :name, :null => false  # special: "unemployed", "retired", "homemaker"

      t.index :name
    end

    create_table :occupation_usages do |t|
      t.references :employee, :null => false # a legal_identity (human)
      t.references :employer # another legal_identity. Special cases: identical (self-employed), nil (unemployed, retired, homemaker)
      t.references :occupation, :null => false

      t.date :from
      t.date :to
      t.datetime :confirmed

      t.integer :lock_version
      t.timestamps

      t.index [:employer_id, :occupation_id]
      t.index [:employee_id, :employer_id]
    end

    create_table :address_usages do |t|
      t.references :legal_identity, :null => false
      t.references :address, :null => false
      t.string :usage # e.g. residential, mailing, billing, voting, fec
      t.date :from
      t.date :to
      t.datetime :confirmed

      t.integer :lock_version
      t.timestamps

      t.index [:legal_identity_id, :usage] # look up the _ address for someone
      t.index [:address_id, :legal_identity_id] # look up who is at the same address
    end

    create_table :legal_name_usages do |t|
      t.references :legal_name, :null => false
      t.references :legal_identity, :null => false
      t.date :from
      t.date :to
      t.string :authority # people can have different names according to different government entities
      t.datetime :confirmed

      t.integer :lock_version
      t.timestamps

      t.index :legal_identity_id
      t.index :legal_name_id
    end

  end
end
