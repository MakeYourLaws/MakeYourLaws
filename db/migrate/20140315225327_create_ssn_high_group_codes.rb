# This migration comes from ssn_validator_engine (originally 20130914201538)
class CreateSsnHighGroupCodes < ActiveRecord::Migration
  def change
    create_table :ssn_high_group_codes do |t|
      t.date :as_of
      t.string :area
      t.string :group
      t.timestamps
    end
    add_index :ssn_high_group_codes, [:area], name: 'idx_area'
    add_index :ssn_high_group_codes, [:area, :as_of], name: 'idx_area_as_of'
  end
end