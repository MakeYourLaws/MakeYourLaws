class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :jurisdiction, :null => false # name of state / county / city
      t.date :election_date
      t.string :election_type, :limit => 15  # primary, general, special
      
      t.string :status # will be used for a (potentially very complicated) finite state machine
      
      t.string :initiator_type, :limit => 30 # legislature, citizen, commission, automatic
      t.string :initiative_type, :limit => 30 # amendment, statute, bond, veto, question, combined amendment & statute, affirmation, recall
      t.boolean :indirect
      
      t.string :initiative_name  # e.g. 11-0035
      t.string :proposition_name # e.g. Proposition 34
      t.string :title, :null => false  # e.g. Death Penalty Repeal
      t.string :informal_title 
      t.text :short_summary   # these are all official by LAO / AG / SoS
      t.text :summary
      t.text :analysis
      t.text :text
      
      t.string :wikipedia_url
      t.string :ballotpedia_url
      
      t.date :filing_date
      t.date :summary_date
      t.date :circulation_deadline
      t.date :full_check_deadline
      
      t.integer :lock_version
      t.timestamps
    end
  
    add_index :initiatives, :jurisdiction
    add_index :initiatives, :election_date
    add_index :initiatives, :election_type
    add_index :initiatives, :status
    add_index :initiatives, :initiative_name
    add_index :initiatives, :proposition_name
    add_index :initiatives, :title
  end  
end
