class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country, :default => "United States", :null => false

      # FEC spec
      t.string :street_address_1, :limit => 34, :null => false
      t.string :street_address_1, :limit => 34
      t.string :city, :limit => 30, :null => false
      t.string :state, :limit => 2, :null => false
      t.integer :zip, :limit => 4 # bytes

      # Geocoding
      t.float :lat, :lng, :precision => 10, :scale => 6

      t.index [:lat, :lng]
      t.index [:country, :state, :city]
    end

    create_table :states do |t|
      t.string :abbreviation, :limit => 2
      t.string :name, :null => false
      t.string :country, :default => "United States", :null => false

      t.index [:country, :abbreviation], :unique => true
      t.index [:country, :name], :unique => true
    end

    us_states = {"AA"=>"Armed Forces Americas", "AE"=>"Armed Forces Europe", "AK"=>"Alaska", "AL"=>"Alabama", "AP"=>"Armed Forces Pacific", "AR"=>"Arkansas", "AS"=>"American Samoa", "AZ"=>"Arizona", "CA"=>"California", "CO"=>"Colorado", "CT"=>"Connecticut", "DC"=>"District of Columbia", "DE"=>"Delaware", "FL"=>"Florida", "FM"=>"Federated States of Micronesia", "GA"=>"Georgia", "GU"=>"Guam", "HI"=>"Hawaii", "IA"=>"Iowa", "ID"=>"Idaho", "IL"=>"Illinois", "IN"=>"Indiana", "KS"=>"Kansas", "KY"=>"Kentucky", "LA"=>"Louisiana", "MA"=>"Massachusetts", "MD"=>"Maryland", "ME"=>"Maine", "MH"=>"Marshall Islands", "MI"=>"Michigan", "MN"=>"Minnesota", "MO"=>"Missouri", "MP"=>"Mariana Islands", "MS"=>"Mississippi", "MT"=>"Montana", "NC"=>"North Carolina", "ND"=>"North Dakota", "NE"=>"Nebraska", "NH"=>"New Hampshire", "NJ"=>"New Jersey", "NM"=>"New Mexico", "NV"=>"Nevada", "NY"=>"New York", "OH"=>"Ohio", "OK"=>"Oklahoma", "OR"=>"Oregon", "PA"=>"Pennsylvania", "PR"=>"Puerto Rico", "PW"=>"Palau", "RI"=>"Rhode Island", "SC"=>"South Carolina", "SD"=>"South Dakota", "TN"=>"Tennessee", "TX"=>"Texas", "UT"=>"Utah", "VA"=>"Virginia", "VI"=>"Virgin Islands", "VT"=>"Vermont", "WA"=>"Washington", "WI"=>"Wisconsin", "WV"=>"West Virginia", "WY"=>"Wyoming", "ZZ"=>"Foreign Countries"}

    State.import [:abbreviation, :name], us_states.to_a

  end
end