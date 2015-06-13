# This migration comes from bit_pay_rails_engine (originally 20150427150251)
class BitPayRailsClient < ActiveRecord::Migration
  def change
    create_table :bit_pay_clients do |t|
      t.string :api_uri
      t.string :pem
      t.string :facade, default: "merchant"

      t.integer :lock_version
      t.timestamps null: false
    end
  end
end
