class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voting_rights do |t|
      t.references :legal_identity
      t.references :district
      t.datetime :from
      t.datetime :to
      t.string :voter_id # gotten from voter registration lists

      t.index [:legal_identity, :district]
      t.index :voter_id
    end

    create_table :districts do |t|
      t.string :level # federal, state, county, city
      t.string :jurisdiction # eg Arizona, US Federal, Alameda, etc
      t.string :branch # eg state, house, ward, etc
      t.string :name # eg 7

      t.index [:jurisdiction, :name]
    end
  end
end
