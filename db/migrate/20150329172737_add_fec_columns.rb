class AddFecColumns < ActiveRecord::Migration
  def change
    change_table :fec_filing_f3 do |t|
      t.decimal :col_a_total_receipts_period, :col_a_subtotals, precision: 12, scale: 2
    end

    create_table :fec_filing_f3z do |t|
      t.string :fec_record_type, limit: 1, default: 'C' # regular Comittee; S = Senate
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_type, :fec_record_number, :row_number], unique: true, name: 'record_index'

      # ^f3z[t]
      t.string :form_type, limit: 8, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :principal_committee_name, limit: 200
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :authorized_committee_id_number, limit: 9
      t.index :authorized_committee_id_number

      t.string :authorized_committee_name, limit: 200
      t.index :authorized_committee_name

      t.decimal :col_a_individual_contributions_itemized, precision: 12, scale: 2
      t.decimal :col_a_political_party_contributions, precision: 12, scale: 2
      t.decimal :col_a_pac_contributions, precision: 12, scale: 2
      t.decimal :col_a_candidate_contributions, precision: 12, scale: 2
      t.decimal :col_a_total_contributions, precision: 12, scale: 2
      t.decimal :col_a_transfers_from_authorized, precision: 12, scale: 2
      t.decimal :col_a_candidate_loans, precision: 12, scale: 2
      t.decimal :col_a_other_loans, precision: 12, scale: 2
      t.decimal :col_a_total_loans, precision: 12, scale: 2
      t.decimal :col_a_offset_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_other_receipts, precision: 12, scale: 2
      t.decimal :col_a_total_receipts, precision: 12, scale: 2
      t.decimal :col_a_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_transfers_to_authorized, precision: 12, scale: 2
      t.decimal :col_a_candidate_loan_repayments, precision: 12, scale: 2
      t.decimal :col_a_other_loan_repayments, precision: 12, scale: 2
      t.decimal :col_a_total_loan_repayments, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_individuals, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_party_committees, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_other_committees, precision: 12, scale: 2
      t.decimal :col_a_total_refunds, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements, precision: 12, scale: 2
      t.decimal :col_a_total_disbursements, precision: 12, scale: 2
      t.decimal :col_a_cash_beginning_reporting_period, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close, precision: 12, scale: 2
      t.decimal :col_a_debts_to, precision: 12, scale: 2
      t.decimal :col_a_debts_by, precision: 12, scale: 2
      t.decimal :col_a_net_contributions, precision: 12, scale: 2
      t.decimal :col_a_net_operating_expenditures, precision: 12, scale: 2

    end

    create_table :fec_filing_sa3l do |t|
      t.string :fec_record_type, limit: 1, default: 'C' # regular Comittee; S = Senate
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_type, :fec_record_number, :row_number], unique: true, name: 'record_index'

      # ^sa3l
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :lobbyist_registrant_organization_name, limit: 200
      t.index :lobbyist_registrant_organization_name

      t.string :lobbyist_registrant_last_name, limit: 30
      t.string :lobbyist_registrant_first_name, limit: 20
      t.string :lobbyist_registrant_middle_name, limit: 20
      t.string :lobbyist_registrant_prefix, limit: 10
      t.string :lobbyist_registrant_suffix, limit: 10
      t.string :lobbyist_registrant_street_1, limit: 34
      t.string :lobbyist_registrant_street_2, limit: 34
      t.string :lobbyist_registrant_city, limit: 30
      t.string :lobbyist_registrant_state, limit: 2
      t.string :lobbyist_registrant_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :contribution_date
      t.decimal :bundled_amount_period, precision: 12, scale: 2
      t.decimal :bundled_amount_semi_annual, precision: 12, scale: 2
      t.string :contribution_purpose_descrip, limit: 100
      t.string :lobbyist_registrant_employer, limit: 38
      t.string :lobbyist_registrant_occupation, limit: 38
      t.string :donor_committee_fec_id, limit: 9
      t.string :donor_committee_name, limit: 90
      t.index :donor_committee_name

      t.string :donor_candidate_fec_id, limit: 9
      t.string :donor_candidate_last_name, limit: 30
      t.string :donor_candidate_first_name, limit: 20
      t.string :donor_candidate_middle_name, limit: 20
      t.string :donor_candidate_prefix, limit: 10
      t.string :donor_candidate_suffix, limit: 10
      t.string :donor_candidate_office, limit: 1
      t.string :donor_candidate_state, limit: 2
      t.string :donor_candidate_district, limit: 2
      t.string :conduit_name, limit: 90
      t.index :conduit_name

      t.string :conduit_street1, limit: 34
      t.string :conduit_street2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :associated_text_record, limit: 1
      t.string :memo_text, limit: 100
      t.string :reference_code, limit: 9
      t.string :contribution_purpose_code, limit: 3
    end
  end
end
