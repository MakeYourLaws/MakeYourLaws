class CreateFecFilings < ActiveRecord::Migration
raise 'not ready yet'

  def change
    # statement of organization
    create_table :fec_filing_f1 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # notification of multicandidate status
    # create_table :fec_filing_f1m do |t|
    #   t.string :fec_id, :limit => 9, :null => false
    #   t.integer :lock_version, :default => 0
    #   t.timestamps
    # end

    # statement of candidacy
    create_table :fec_filing_f2 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # 24/48 hour notice of independent expenditures or coordinated expenditures
    create_table :fec_filing_f24 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # report of receipts & disbursements - authorized committee
    create_table :fec_filing_f3 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # report of receipts & disbursements - authorized committee (president / vice president)
    create_table :fec_filing_f3p do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # F3PS
    # F3P31 (Items to be Liquidated)
    # F3S
    
    # report of receipts & disbursements - non-authorized committee
    create_table :fec_filing_f3x do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # report of contributions bundled by lobbyist/registrants and lobbyist/registrant PACs
    create_table :fec_filing_f3l do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # report of receipts & disbursements - convention committee
    create_table :fec_filing_f4 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end

    # report of independent expenditures made & contributions received
    create_table :fec_filing_f5 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # F56 (Contributions for Independent Expenditures)
    # F57 (Independent Expenditures)

    # 48 hour notice of contributions/loans received
    create_table :fec_filing_f6 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # F65 (Contributions for 48 Hour Notices)
    
    # report of communication costs - corporations and membership organizations
    # create_table :fec_filing_f7 do |t|
    #   t.string :fec_id, :limit => 9, :null => false
    #   t.integer :lock_version, :default => 0
    #   t.timestamps
    # end
    
    # debt settlement plan
    # create_table :fec_filing_f8 do |t|
    #   t.string :fec_id, :limit => 9, :null => false
    #   t.integer :lock_version, :default => 0
    #   t.timestamps
    # end
    
    # 24 hour notice of disbursement/obligations for electioneering communications
    create_table :fec_filing_f9 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # 24 hour notice of expenditure from candidate's personal funds
    create_table :fec_filing_f10 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # report of donations accepted for inaugural committee
    create_table :fec_filing_f13 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # F91 (Lists of Persons Exercising Control)
    # F92 (Contributions for Electioneering Communications)
    # F93 (Expenditures for Electioneering Communications)
    # F94 (Federal Candidates List for Electioneering Communications)
    
    # miscellaneous text
    create_table :fec_filing_f99 do |t|
      t.string :fec_id, :limit => 9, :null => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end
    
    # H1 (Method of Allocation for Federal/Non-Federal Activity)
    # H2 (Federal/Non-Federal Allocation Ratios)
    # H3 (Transfers from Non-Federal Accounts)
    # H4 (Disbursements for Allocated Federal/Non-Federal Activity)
    # H5 (Transfers from Levin Funds)
    # H6 (Disbursements from Levin Funds)
    # SA (Contributions)
    # SB (Expenditures)
    # SC (Loans)
    # SC1
    # SC2
    # SD (Debts & Obligations)
    # SE (Independent Expenditures)
    # SF (Coordinated Expenditures)
    # SL (Levin Fund Summary)    
    
  end
end
