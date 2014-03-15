class CreateOfacSdns < ActiveRecord::Migration
  
  def self.up
    create_table :ofac_sdns do |t|
      t.text      :name
      t.string    :sdn_type
      t.string    :program
      t.string    :title
      t.string    :vessel_call_sign
      t.string    :vessel_type
      t.string    :vessel_tonnage
      t.string    :gross_registered_tonnage
      t.string    :vessel_flag
      t.string    :vessel_owner
      t.text      :remarks
      t.text      :address
      t.string    :city
      t.string    :country
      t.string    :address_remarks
      t.string    :alternate_identity_type
      t.text      :alternate_identity_name
      t.string    :alternate_identity_remarks
      t.timestamps
    end
    add_index :ofac_sdns, :sdn_type
  end
  
  def self.down
    drop_table :ofac_sdns
  end
end