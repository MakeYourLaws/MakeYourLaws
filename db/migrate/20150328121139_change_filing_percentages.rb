class ChangeFilingPercentages < ActiveRecord::Migration
  def change
    # H1 (Method of Allocation for Federal/Non-Federal Activity)
    change_table :fec_filing_h1 do |t|
      t.change :flat_minimum_federal_percentage, :decimal, precision: 8, scale: 5
      t.change :federal_percent, :decimal, precision: 8, scale: 5
      t.change :nonfederal_percent, :decimal, precision: 8, scale: 5
      t.change :national_party_committee_percentage, :decimal, precision: 8, scale: 5
      t.change :hsp_committees_minimum_federal_percentage, :decimal, precision: 8, scale: 5
      t.change :hsp_committees_percentage_federal_candidate_support, :decimal, precision: 8, scale: 5
      t.change :hsp_committees_percentage_nonfederal_candidate_support, :decimal, precision: 8, scale: 5
      t.change :hsp_committees_percentage_nonfederal_candidate_support, :decimal, precision: 8, scale: 5
      t.change :hsp_committees_percentage_actual_federal, :decimal, precision: 8, scale: 5
      t.change :actual_direct_candidate_support_federal_percent, :decimal, precision: 8, scale: 5
    end

    # H2 (Federal/Non-Federal Allocation Ratios)
    change_table :fec_filing_h2 do |t|
      t.change :federal_percentage, :decimal, precision: 8, scale: 5
      t.change :nonfederal_percentage, :decimal, precision: 8, scale: 5
    end
  end
end
