class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.references :legal_committee, :polymorphic => true # eg an Fec::Committee, etc
      
      t.string :jurisdiction, :null => false # e.g. "California", "United States"
      t.string :acronym
      t.string :short_name # e.g. "No on 29"
      t.string :full_name, :null => false # full formal name, e.g. "No on 29—Californians Against Out-of-Control Taxes and Spending, a coalition of taxpayers, small businesses, law enforcement and labor"
      t.string :type # e.g. general purpose, small contributor, independent expenditure, non-contribution
      t.string :legal_id # according to the state campaign finance regulator
      
      # TODO: normalize out
      # This is the corporation owning the committee, if any
      t.string :corporation_acronym
      t.string :corporation_full_name
      t.string :corporation_type # 501(c)3, 501(c)4, 527 PAC, 527 multicandidate PAC, 527 Super PAC, 527 Hybrid Super PAC, 527 Non-PAC, 527 SSF, 527 Leadership PAC, etc
      t.string :corporation_ein
      
      t.string :contact_name # i.e. the main human in charge
      t.string :contact_title
      t.string :email
      t.string :phone
      t.string :url
      t.string :party # if affiliated
      
      t.string :address # for sending checks; will be made out to the full name
      t.string :paypal_email
      
      t.string :status
      t.text :notes # for admins only
      
      t.boolean :foreign_contributions_okay, :default => false
      
      t.integer :lock_version
      t.timestamps
    end
    
    
    create_table :initiative_support do |t|
      t.references :initiative, :null => false
      t.references :committee, :null => false 
      
      t.boolean :support, :default => nil # false = oppose, nil = neutral but still spending on it
      t.boolean :primary, :default => false # support: proponent; oppose: largest / most official opponent
      
      t.text :statement
      t.string :url # more on their position
      
      t.integer :lock_version
      t.timestamps
    end
    
  end
end
