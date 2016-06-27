class FixNames < ActiveRecord::Migration
  def change
    rename_column :fec_filing_sc, :lender_candidate_middle_nm, :lender_candidate_middle_name
  end
end
