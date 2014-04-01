class CreateLegalIdentities < ActiveRecord::Migration
  def change
    create_table :legal_identities do |t|
      # Both humans and corporations
      t.date :birthdate
      # This is actually 1:M not 1:1 (EIN/SSN/etc can be changed), but for now we're not handling that
      t.integer :irs_id, :limit => 4 # bytes — EIN for corps, SSN for humans
      t.integer :party_id # refers to an FEC::Committee ID this entity is formally affiliated with (if any)

      # Human specific
      t.boolean :us_citizen_or_greencard # US Citizen or permanent resident / green card holder?
      t.boolean :govt_contractor
      t.references :employer # a legal_identity. Special cases: self.id (self-employed), nil (unemployed)
      t.references :occupation

      t.integer :lock_version
      t.timestamps

      t.index :irs_id, :unique => true # allows nil in most DBs
      t.index :employer  # for autocomplete
      t.index :occupation
    end

    create_table :occupations do |t|
      t.string :name, :null => false  # special: "unemployed", "retired", "homemaker"
      t.string :irs_id

      t.index :name
    end

    create_table :address_usages do |t|
      t.references :legal_identity
      t.references :address
      t.string :type # e.g. residential, mailing, billing, voting, fec
      t.date :from
      t.date :to

      t.index [:legal_identity, :type]
    end

    create_table :name_usages do |t|
      t.references :legal_name
      t.references :legal_identity
      t.date :from
      t.date :to
      t.string :authority # people can have different names according to different government entities
    end

    create_table :legal_names do |t|
      t.string :full_name
      t.string :name_prefix, :length => 10 # Based on FEC filing requirements
      t.string :first_name, :length => 50
      t.string :middle_name, :length => 50
      t.string :last_name, :length => 50
      t.string :name_suffix, :length => 10 # Jr., Sr., I, II, etc

      t.integer :lock_version
      t.timestamps

      t.index [:legal_idenity, :from]
    end
  end
end
