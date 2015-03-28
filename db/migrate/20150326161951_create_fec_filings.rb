class CreateFecFilings < ActiveRecord::Migration
  def change
    create_table :fec_filing_hdr do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      t.string :record_type, limit: 3
      t.string :ef_type, limit: 3
      t.string :fec_version, limit: 4
      t.string :soft_name, limit: 90
      t.string :soft_ver, limit: 16
      t.string :report_id, limit: 16
      t.index :report_id

      t.integer :report_number, unsigned: true
      t.string :comment, limit: 200
      t.string :name_delim, limit: 1
    end

    # statement of organization - ^f1[an]
    create_table :fec_filing_f1 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :change_of_committee_name, limit: 1
      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :change_of_committee_email, limit: 1
      t.string :committee_email, limit: 90
      t.string :change_of_committee_url, limit: 1
      t.string :committee_url, limit: 90
      t.date :effective_date
      t.string :signature_last_name, limit: 30
      t.string :signature_first_name, limit: 20
      t.string :signature_middle_name, limit: 20
      t.string :signature_prefix, limit: 10
      t.string :signature_suffix, limit: 10
      t.date :date_signed
      t.string :committee_type, limit: 1
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :party_code, limit: 3
      t.string :party_type, limit: 3
      t.string :organization_type, limit: 1
      t.string :lobbyist_registrant_pac, limit: 1
      t.string :lobbyist_registrant_pac_2, limit: 1
      t.string :leadership_pac, limit: 1
      t.string :affiliated_committee_id_number, limit: 9
      t.index :affiliated_committee_id_number

      t.string :affiliated_committee_name, limit: 200
      t.index :affiliated_committee_name

      t.string :affiliated_candidate_id_number, limit: 9
      t.index :affiliated_candidate_id_number

      t.string :affiliated_last_name, limit: 30
      t.string :affiliated_first_name, limit: 20
      t.string :affiliated_middle_name, limit: 20
      t.string :affiliated_prefix, limit: 10
      t.string :affiliated_suffix, limit: 10
      t.string :affiliated_street_1, limit: 34
      t.string :affiliated_street_2, limit: 34
      t.string :affiliated_city, limit: 30
      t.string :affiliated_state, limit: 2
      t.string :affiliated_zip_code, limit: 9
      t.string :affiliated_relationship_code, limit: 38
      t.string :custodian_last_name, limit: 30
      t.string :custodian_first_name, limit: 20
      t.string :custodian_middle_name, limit: 20
      t.string :custodian_prefix, limit: 10
      t.string :custodian_suffix, limit: 10
      t.string :custodian_street_1, limit: 34
      t.string :custodian_street_2, limit: 34
      t.string :custodian_city, limit: 30
      t.string :custodian_state, limit: 2
      t.string :custodian_zip_code, limit: 9
      t.string :custodian_title, limit: 20
      t.string :custodian_telephone, limit: 10
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.string :treasurer_street_1, limit: 34
      t.string :treasurer_street_2, limit: 34
      t.string :treasurer_city, limit: 30
      t.string :treasurer_state, limit: 2
      t.string :treasurer_zip_code, limit: 9
      t.string :treasurer_title, limit: 20
      t.string :treasurer_telephone, limit: 10
      t.string :agent_last_name, limit: 30
      t.string :agent_first_name, limit: 20
      t.string :agent_middle_name, limit: 20
      t.string :agent_prefix, limit: 10
      t.string :agent_suffix, limit: 10
      t.string :agent_street_1, limit: 34
      t.string :agent_street_2, limit: 34
      t.string :agent_city, limit: 30
      t.string :agent_state, limit: 2
      t.string :agent_zip_code, limit: 9
      t.string :agent_title, limit: 20
      t.string :agent_telephone, limit: 10
      t.string :bank_name, limit: 200
      t.index :bank_name

      t.string :bank_street_1, limit: 34
      t.string :bank_street_2, limit: 34
      t.string :bank_city, limit: 30
      t.string :bank_state, limit: 2
      t.string :bank_zip_code, limit: 9
      t.string :bank2_name, limit: 200
      t.index :bank2_name

      t.string :bank2_street_1, limit: 34
      t.string :bank2_street_2, limit: 34
      t.string :bank2_city, limit: 30
      t.string :bank2_state, limit: 2
      t.string :bank2_zip_code, limit: 9

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :custodian_name, limit: 200
      t.index :custodian_name

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

      t.string :agent_name, limit: 200
      t.index :agent_name

      t.string :signature_name, limit: 200
      t.index :signature_name

      t.string :committee_fax_number, limit: 10
    end

    # notification of multicandidate status
    create_table :fec_filing_f1m do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f1m[a|n])
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :committee_type, limit: 1
      t.date :affiliated_date_f1_filed
      t.string :affiliated_committee_id_number, limit: 9
      t.index :affiliated_committee_id_number

      t.string :affiliated_committee_name, limit: 200
      t.index :affiliated_committee_name

      t.string :first_candidate_id_number, limit: 9
      t.index :first_candidate_id_number

      t.string :first_candidate_last_name, limit: 30
      t.string :first_candidate_first_name, limit: 20
      t.string :first_candidate_middle_name, limit: 20
      t.string :first_candidate_prefix, limit: 10
      t.string :first_candidate_suffix, limit: 10
      t.string :first_candidate_office, limit: 1
      t.string :first_candidate_state, limit: 2
      t.string :first_candidate_district, limit: 2
      t.date :first_candidate_contribution_date
      t.string :second_candidate_id_number, limit: 9
      t.index :second_candidate_id_number

      t.string :second_candidate_last_name, limit: 30
      t.string :second_candidate_second_name, limit: 200
      t.index :second_candidate_second_name

      t.string :second_candidate_middle_name, limit: 20
      t.string :second_candidate_prefix, limit: 10
      t.string :second_candidate_suffix, limit: 10
      t.string :second_candidate_office, limit: 1
      t.string :second_candidate_state, limit: 2
      t.string :second_candidate_district, limit: 2
      t.date :second_candidate_contribution_date
      t.string :third_candidate_id_number, limit: 9
      t.index :third_candidate_id_number

      t.string :third_candidate_last_name, limit: 30
      t.string :third_candidate_third_name, limit: 200
      t.index :third_candidate_third_name

      t.string :third_candidate_middle_name, limit: 20
      t.string :third_candidate_prefix, limit: 10
      t.string :third_candidate_suffix, limit: 10
      t.string :third_candidate_office, limit: 1
      t.string :third_candidate_state, limit: 2
      t.string :third_candidate_district, limit: 2
      t.date :third_candidate_contribution_date
      t.string :fourth_candidate_id_number, limit: 9
      t.index :fourth_candidate_id_number

      t.string :fourth_candidate_last_name, limit: 30
      t.string :fourth_candidate_fourth_name, limit: 200
      t.index :fourth_candidate_fourth_name

      t.string :fourth_candidate_middle_name, limit: 20
      t.string :fourth_candidate_prefix, limit: 10
      t.string :fourth_candidate_suffix, limit: 10
      t.string :fourth_candidate_office, limit: 1
      t.string :fourth_candidate_state, limit: 2
      t.string :fourth_candidate_district, limit: 2
      t.date :fourth_candidate_contribution_date
      t.string :fifth_candidate_id_number, limit: 9
      t.index :fifth_candidate_id_number

      t.string :fifth_candidate_last_name, limit: 30
      t.string :fifth_candidate_fifth_name, limit: 200
      t.index :fifth_candidate_fifth_name

      t.string :fifth_candidate_middle_name, limit: 20
      t.string :fifth_candidate_prefix, limit: 10
      t.string :fifth_candidate_suffix, limit: 10
      t.string :fifth_candidate_office, limit: 1
      t.string :fifth_candidate_state, limit: 2
      t.string :fifth_candidate_district, limit: 2
      t.date :fifth_candidate_contribution_date
      t.date :fifty_first_contributor_date
      t.date :original_registration_date
      t.date :requirements_met_date
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed

      t.string :first_candidate_name, limit: 200
      t.index :first_candidate_name

      t.string :second_candidate_name, limit: 200
      t.index :second_candidate_name

      t.string :third_candidate_name, limit: 200
      t.index :third_candidate_name

      t.string :fourth_candidate_name, limit: 200
      t.index :fourth_candidate_name

      t.string :fifth_candidate_name, limit: 200
      t.index :fifth_candidate_name

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

    end

    create_table :fec_filing_f1s do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f1s
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :joint_fund_participant_committee_name, limit: 200
      t.index :joint_fund_participant_committee_name, name: 'index_fec_filing_f1s_on_jfp_cn'

      t.string :joint_fund_participant_committee_id_number, limit: 9
      t.index :joint_fund_participant_committee_id_number, name: 'index_fec_filing_f1s_on_jfp_cid'

      t.string :affiliated_committee_id_number, limit: 9
      t.index :affiliated_committee_id_number

      t.string :affiliated_committee_name, limit: 200
      t.index :affiliated_committee_name

      t.string :affiliated_candidate_id_number, limit: 9
      t.index :affiliated_candidate_id_number

      t.string :affiliated_last_name, limit: 30
      t.string :affiliated_first_name, limit: 20
      t.string :affiliated_middle_name, limit: 20
      t.string :affiliated_prefix, limit: 10
      t.string :affiliated_suffix, limit: 10
      t.string :affiliated_street_1, limit: 34
      t.string :affiliated_street_2, limit: 34
      t.string :affiliated_city, limit: 30
      t.string :affiliated_state, limit: 2
      t.string :affiliated_zip_code, limit: 9
      t.string :affiliated_relationship_code, limit: 38
      t.string :agent_last_name, limit: 30
      t.string :agent_first_name, limit: 20
      t.string :agent_middle_name, limit: 20
      t.string :agent_prefix, limit: 10
      t.string :agent_suffix, limit: 10
      t.string :agent_street_1, limit: 34
      t.string :agent_street_2, limit: 34
      t.string :agent_city, limit: 30
      t.string :agent_state, limit: 2
      t.string :agent_zip_code, limit: 9
      t.string :agent_title, limit: 20
      t.string :agent_telephone, limit: 10
      t.string :bank_name, limit: 200
      t.index :bank_name

      t.string :bank_street_1, limit: 34
      t.string :bank_street_2, limit: 34
      t.string :bank_city, limit: 30
      t.string :bank_state, limit: 2
      t.string :bank_zip_code, limit: 9
    end

    # statement of candidacy
    create_table :fec_filing_f2 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f2$)|(^f2[^4])
      t.string :form_type, limit: 8
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :change_of_address, limit: 1
      t.string :candidate_street_1, limit: 34
      t.string :candidate_street_2, limit: 34
      t.string :candidate_city, limit: 30
      t.string :candidate_state, limit: 2
      t.string :candidate_zip_code, limit: 9
      t.string :candidate_party_code, limit: 3
      t.string :candidate_office, limit: 1
      t.string :candidate_district, limit: 2
      t.integer :election_year, unsigned: true
      t.string :committee_id_number, limit: 9
      t.index :committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :committee_street_1, limit: 34
      t.string :committee_street_2, limit: 34
      t.string :committee_city, limit: 30
      t.string :committee_state, limit: 2
      t.string :committee_zip_code, limit: 9
      t.string :authorized_committee_id_number, limit: 9
      t.index :authorized_committee_id_number

      t.string :authorized_committee_name, limit: 200
      t.index :authorized_committee_name

      t.string :authorized_committee_street_1, limit: 34
      t.string :authorized_committee_street_2, limit: 34
      t.string :authorized_committee_city, limit: 30
      t.string :authorized_committee_state, limit: 2
      t.string :authorized_committee_zip_code, limit: 9
      t.string :candidate_signature_last_name, limit: 30
      t.string :candidate_signature_first_name, limit: 20
      t.string :candidate_signature_middle_name, limit: 20
      t.string :candidate_signature_prefix, limit: 10
      t.string :candidate_signature_suffix, limit: 10
      t.date :date_signed

      t.decimal :primary_personal_funds_declared, precision: 12, scale: 2
      t.decimal :general_personal_funds_declared, precision: 12, scale: 2
      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_signature_name, limit: 200
      t.index :candidate_signature_name

    end

    # 24/48 hour notice of independent expenditures or coordinated expenditures
    create_table :fec_filing_f24 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f24$)|(^f24[an])
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :report_type, limit: 3
      t.date :original_amendment_date
      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
    end

    # report of receipts & disbursements - authorized committee
    create_table :fec_filing_f3 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f3[a|n|t]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :election_state, limit: 2
      t.string :election_district, limit: 2
      t.string :report_code, limit: 3
      t.string :election_code, limit: 5
      t.date :election_date
      t.string :state_of_election, limit: 2
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.decimal :col_a_total_contributions_no_loans, precision: 12, scale: 2
      t.decimal :col_a_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_a_net_contributions, precision: 12, scale: 2
      t.decimal :col_a_total_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_total_offset_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_net_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_a_debts_to, precision: 12, scale: 2
      t.decimal :col_a_debts_by, precision: 12, scale: 2
      t.decimal :col_a_individual_contributions_itemized, precision: 12, scale: 2
      t.decimal :col_a_individual_contributions_unitemized, precision: 12, scale: 2
      t.decimal :col_a_total_individual_contributions, precision: 12, scale: 2
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
      t.decimal :col_a_total_disbursements_period, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close, precision: 12, scale: 2
      t.decimal :col_b_total_contributions_no_loans, precision: 12, scale: 2
      t.decimal :col_b_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_b_net_contributions, precision: 12, scale: 2
      t.decimal :col_b_total_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_total_offset_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_net_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_individual_contributions_itemized, precision: 12, scale: 2
      t.decimal :col_b_individual_contributions_unitemized, precision: 12, scale: 2
      t.decimal :col_b_total_individual_contributions, precision: 12, scale: 2
      t.decimal :col_b_political_party_contributions, precision: 12, scale: 2
      t.decimal :col_b_pac_contributions, precision: 12, scale: 2
      t.decimal :col_b_candidate_contributions, precision: 12, scale: 2
      t.decimal :col_b_total_contributions, precision: 12, scale: 2
      t.decimal :col_b_transfers_from_authorized, precision: 12, scale: 2
      t.decimal :col_b_candidate_loans, precision: 12, scale: 2
      t.decimal :col_b_other_loans, precision: 12, scale: 2
      t.decimal :col_b_total_loans, precision: 12, scale: 2
      t.decimal :col_b_offset_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_other_receipts, precision: 12, scale: 2
      t.decimal :col_b_total_receipts, precision: 12, scale: 2
      t.decimal :col_b_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_transfers_to_authorized, precision: 12, scale: 2
      t.decimal :col_b_candidate_loan_repayments, precision: 12, scale: 2
      t.decimal :col_b_other_loan_repayments, precision: 12, scale: 2
      t.decimal :col_b_total_loan_repayments, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_individuals, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_party_committees, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_other_committees, precision: 12, scale: 2
      t.decimal :col_b_total_refunds, precision: 12, scale: 2
      t.decimal :col_b_other_disbursements, precision: 12, scale: 2
      t.decimal :col_b_total_disbursements, precision: 12, scale: 2
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :report_type, limit: 3
      t.decimal :col_b_gross_receipts_authorized_primary, precision: 12, scale: 2
      t.decimal :col_b_aggregate_personal_funds_primary, precision: 12, scale: 2
      t.decimal :col_b_gross_receipts_minus_personal_funds_primary, precision: 12, scale: 2
      t.decimal :col_b_gross_receipts_authorized_general, precision: 12, scale: 2
      t.decimal :col_b_aggregate_personal_funds_general, precision: 12, scale: 2
      t.decimal :col_b_gross_receipts_minus_personal_funds_general, precision: 12, scale: 2

      t.string :primary_election, limit: 1
      t.string :general_election, limit: 1
      t.string :special_election, limit: 1
      t.string :runoff_election, limit: 1
      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

      t.string :candidate_name, limit: 200
      t.index :candidate_name

    end

    # report of receipts & disbursements - authorized committee (president / vice president)
    create_table :fec_filing_f3p do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f3p$)|(^f3p[^s|3])
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :activity_primary, limit: 1
      t.string :activity_general, limit: 1
      t.string :report_code, limit: 3
      t.string :election_code, limit: 5
      t.date :date_of_election
      t.string :state_of_election, limit: 2
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.decimal :col_a_cash_on_hand_beginning_period, precision: 12, scale: 2
      t.decimal :col_a_total_receipts, precision: 12, scale: 2
      t.decimal :col_a_subtotal, precision: 12, scale: 2
      t.decimal :col_a_total_disbursements, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_a_debts_to, precision: 12, scale: 2
      t.decimal :col_a_debts_by, precision: 12, scale: 2
      t.decimal :col_a_expenditures_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_a_net_contributions, precision: 12, scale: 2
      t.decimal :col_a_net_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_federal_funds, precision: 12, scale: 2
      t.decimal :col_a_individuals_itemized, precision: 12, scale: 2
      t.decimal :col_a_individuals_unitemized, precision: 12, scale: 2
      t.decimal :col_a_individual_contribution_total, precision: 12, scale: 2
      t.decimal :col_a_political_party_committees_receipts, precision: 12, scale: 2
      t.decimal :col_a_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :col_a_the_candidate, precision: 12, scale: 2
      t.decimal :col_a_total_contributions, precision: 12, scale: 2
      t.decimal :col_a_transfers_from_aff_other_party_cmttees, precision: 12, scale: 2
      t.decimal :col_a_received_from_or_guaranteed_by_cand, precision: 12, scale: 2
      t.decimal :col_a_other_loans, precision: 12, scale: 2
      t.decimal :col_a_total_loans, precision: 12, scale: 2
      t.decimal :col_a_operating, precision: 12, scale: 2
      t.decimal :col_a_fundraising, precision: 12, scale: 2
      t.decimal :col_a_legal_and_accounting, precision: 12, scale: 2
      t.decimal :col_a_total_offsets_to_expenditures, precision: 12, scale: 2
      t.decimal :col_a_other_receipts, precision: 12, scale: 2
      t.decimal :col_a_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_transfers_to_other_authorized_committees, precision: 12, scale: 2
      t.decimal :col_a_fundraising_disbursements, precision: 12, scale: 2
      t.decimal :col_a_exempt_legal_accounting_disbursement, precision: 12, scale: 2
      t.decimal :col_a_made_or_guaranteed_by_candidate, precision: 12, scale: 2
      t.decimal :col_a_other_repayments, precision: 12, scale: 2
      t.decimal :col_a_total_loan_repayments_made, precision: 12, scale: 2
      t.decimal :col_a_individuals, precision: 12, scale: 2
      t.decimal :col_a_political_party_committees_refunds, precision: 12, scale: 2
      t.decimal :col_a_other_political_committees, precision: 12, scale: 2
      t.decimal :col_a_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements, precision: 12, scale: 2
      t.decimal :col_a_items_on_hand_to_be_liquidated, precision: 12, scale: 2
      t.decimal :col_a_alabama, precision: 12, scale: 2
      t.decimal :col_a_alaska, precision: 12, scale: 2
      t.decimal :col_a_arizona, precision: 12, scale: 2
      t.decimal :col_a_arkansas, precision: 12, scale: 2
      t.decimal :col_a_california, precision: 12, scale: 2
      t.decimal :col_a_colorado, precision: 12, scale: 2
      t.decimal :col_a_connecticut, precision: 12, scale: 2
      t.decimal :col_a_delaware, precision: 12, scale: 2
      t.decimal :col_a_dist_of_columbia, precision: 12, scale: 2
      t.decimal :col_a_florida, precision: 12, scale: 2
      t.decimal :col_a_georgia, precision: 12, scale: 2
      t.decimal :col_a_hawaii, precision: 12, scale: 2
      t.decimal :col_a_idaho, precision: 12, scale: 2
      t.decimal :col_a_illinois, precision: 12, scale: 2
      t.decimal :col_a_indiana, precision: 12, scale: 2
      t.decimal :col_a_iowa, precision: 12, scale: 2
      t.decimal :col_a_kansas, precision: 12, scale: 2
      t.decimal :col_a_kentucky, precision: 12, scale: 2
      t.decimal :col_a_louisiana, precision: 12, scale: 2
      t.decimal :col_a_maine, precision: 12, scale: 2
      t.decimal :col_a_maryland, precision: 12, scale: 2
      t.decimal :col_a_massachusetts, precision: 12, scale: 2
      t.decimal :col_a_michigan, precision: 12, scale: 2
      t.decimal :col_a_minnesota, precision: 12, scale: 2
      t.decimal :col_a_mississippi, precision: 12, scale: 2
      t.decimal :col_a_missouri, precision: 12, scale: 2
      t.decimal :col_a_montana, precision: 12, scale: 2
      t.decimal :col_a_nebraska, precision: 12, scale: 2
      t.decimal :col_a_nevada, precision: 12, scale: 2
      t.decimal :col_a_new_hampshire, precision: 12, scale: 2
      t.decimal :col_a_new_jersey, precision: 12, scale: 2
      t.decimal :col_a_new_mexico, precision: 12, scale: 2
      t.decimal :col_a_new_york, precision: 12, scale: 2
      t.decimal :col_a_north_carolina, precision: 12, scale: 2
      t.decimal :col_a_north_dakota, precision: 12, scale: 2
      t.decimal :col_a_ohio, precision: 12, scale: 2
      t.decimal :col_a_oklahoma, precision: 12, scale: 2
      t.decimal :col_a_oregon, precision: 12, scale: 2
      t.decimal :col_a_pennsylvania, precision: 12, scale: 2
      t.decimal :col_a_rhode_island, precision: 12, scale: 2
      t.decimal :col_a_south_carolina, precision: 12, scale: 2
      t.decimal :col_a_south_dakota, precision: 12, scale: 2
      t.decimal :col_a_tennessee, precision: 12, scale: 2
      t.decimal :col_a_texas, precision: 12, scale: 2
      t.decimal :col_a_utah, precision: 12, scale: 2
      t.decimal :col_a_vermont, precision: 12, scale: 2
      t.decimal :col_a_virginia, precision: 12, scale: 2
      t.decimal :col_a_washington, precision: 12, scale: 2
      t.decimal :col_a_west_virginia, precision: 12, scale: 2
      t.decimal :col_a_wisconsin, precision: 12, scale: 2
      t.decimal :col_a_wyoming, precision: 12, scale: 2
      t.decimal :col_a_puerto_rico, precision: 12, scale: 2
      t.decimal :col_a_guam, precision: 12, scale: 2
      t.decimal :col_a_virgin_islands, precision: 12, scale: 2
      t.decimal :col_a_totals, precision: 12, scale: 2
      t.decimal :col_b_federal_funds, precision: 12, scale: 2
      t.decimal :col_b_individuals_itemized, precision: 12, scale: 2
      t.decimal :col_b_individuals_unitemized, precision: 12, scale: 2
      t.decimal :col_b_individual_contribution_total, precision: 12, scale: 2
      t.decimal :col_b_political_party_committees_receipts, precision: 12, scale: 2
      t.decimal :col_b_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :col_b_the_candidate, precision: 12, scale: 2
      t.decimal :col_b_total_contributions_other_than_loans, precision: 12, scale: 2
      t.decimal :col_b_transfers_from_aff_other_party_cmttees, precision: 12, scale: 2
      t.decimal :col_b_received_from_or_guaranteed_by_cand, precision: 12, scale: 2
      t.decimal :col_b_other_loans, precision: 12, scale: 2
      t.decimal :col_b_total_loans, precision: 12, scale: 2
      t.decimal :col_b_operating, precision: 12, scale: 2
      t.decimal :col_b_fundraising, precision: 12, scale: 2
      t.decimal :col_b_legal_and_accounting, precision: 12, scale: 2
      t.decimal :col_b_total_offsets_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_other_receipts, precision: 12, scale: 2
      t.decimal :col_b_total_receipts, precision: 12, scale: 2
      t.decimal :col_b_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_transfers_to_other_authorized_committees, precision: 12, scale: 2
      t.decimal :col_b_fundraising_disbursements, precision: 12, scale: 2
      t.decimal :col_b_exempt_legal_accounting_disbursement, precision: 12, scale: 2
      t.decimal :col_b_made_or_guaranteed_by_the_candidate, precision: 12, scale: 2
      t.decimal :col_b_other_repayments, precision: 12, scale: 2
      t.decimal :col_b_total_loan_repayments_made, precision: 12, scale: 2
      t.decimal :col_b_individuals, precision: 12, scale: 2
      t.decimal :col_b_political_party_committees_refunds, precision: 12, scale: 2
      t.decimal :col_b_other_political_committees, precision: 12, scale: 2
      t.decimal :col_b_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_b_other_disbursements, precision: 12, scale: 2
      t.decimal :col_b_total_disbursements, precision: 12, scale: 2
      t.decimal :col_b_alabama, precision: 12, scale: 2
      t.decimal :col_b_alaska, precision: 12, scale: 2
      t.decimal :col_b_arizona, precision: 12, scale: 2
      t.decimal :col_b_arkansas, precision: 12, scale: 2
      t.decimal :col_b_california, precision: 12, scale: 2
      t.decimal :col_b_colorado, precision: 12, scale: 2
      t.decimal :col_b_connecticut, precision: 12, scale: 2
      t.decimal :col_b_delaware, precision: 12, scale: 2
      t.decimal :col_b_dist_of_columbia, precision: 12, scale: 2
      t.decimal :col_b_florida, precision: 12, scale: 2
      t.decimal :col_b_georgia, precision: 12, scale: 2
      t.decimal :col_b_hawaii, precision: 12, scale: 2
      t.decimal :col_b_idaho, precision: 12, scale: 2
      t.decimal :col_b_illinois, precision: 12, scale: 2
      t.decimal :col_b_indiana, precision: 12, scale: 2
      t.decimal :col_b_iowa, precision: 12, scale: 2
      t.decimal :col_b_kansas, precision: 12, scale: 2
      t.decimal :col_b_kentucky, precision: 12, scale: 2
      t.decimal :col_b_louisiana, precision: 12, scale: 2
      t.decimal :col_b_maine, precision: 12, scale: 2
      t.decimal :col_b_maryland, precision: 12, scale: 2
      t.decimal :col_b_massachusetts, precision: 12, scale: 2
      t.decimal :col_b_michigan, precision: 12, scale: 2
      t.decimal :col_b_minnesota, precision: 12, scale: 2
      t.decimal :col_b_mississippi, precision: 12, scale: 2
      t.decimal :col_b_missouri, precision: 12, scale: 2
      t.decimal :col_b_montana, precision: 12, scale: 2
      t.decimal :col_b_nebraska, precision: 12, scale: 2
      t.decimal :col_b_nevada, precision: 12, scale: 2
      t.decimal :col_b_new_hampshire, precision: 12, scale: 2
      t.decimal :col_b_new_jersey, precision: 12, scale: 2
      t.decimal :col_b_new_mexico, precision: 12, scale: 2
      t.decimal :col_b_new_york, precision: 12, scale: 2
      t.decimal :col_b_north_carolina, precision: 12, scale: 2
      t.decimal :col_b_north_dakota, precision: 12, scale: 2
      t.decimal :col_b_ohio, precision: 12, scale: 2
      t.decimal :col_b_oklahoma, precision: 12, scale: 2
      t.decimal :col_b_oregon, precision: 12, scale: 2
      t.decimal :col_b_pennsylvania, precision: 12, scale: 2
      t.decimal :col_b_rhode_island, precision: 12, scale: 2
      t.decimal :col_b_south_carolina, precision: 12, scale: 2
      t.decimal :col_b_south_dakota, precision: 12, scale: 2
      t.decimal :col_b_tennessee, precision: 12, scale: 2
      t.decimal :col_b_texas, precision: 12, scale: 2
      t.decimal :col_b_utah, precision: 12, scale: 2
      t.decimal :col_b_vermont, precision: 12, scale: 2
      t.decimal :col_b_virginia, precision: 12, scale: 2
      t.decimal :col_b_washington, precision: 12, scale: 2
      t.decimal :col_b_west_virginia, precision: 12, scale: 2
      t.decimal :col_b_wisconsin, precision: 12, scale: 2
      t.decimal :col_b_wyoming, precision: 12, scale: 2
      t.decimal :col_b_puerto_rico, precision: 12, scale: 2
      t.decimal :col_b_guam, precision: 12, scale: 2
      t.decimal :col_b_virgin_islands, precision: 12, scale: 2
      t.decimal :col_b_totals, precision: 12, scale: 2

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

    end

    create_table :fec_filing_f3p31 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps

      # ^f3p31
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :item_description, limit: 100
      t.date :item_contribution_aquired_date
      t.decimal :item_fair_market_value, precision: 12, scale: 2
      t.string :contributor_employer, limit: 38
      t.string :contributor_occupation, limit: 38
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100

      t.string :contributor_name, limit: 200
      t.index :contributor_name

      t.string :transaction_code, limit: 3
      t.string :transaction_description, limit: 40
      t.string :fec_committee_id_number, limit: 9
      t.index :fec_committee_id_number

      t.string :fec_candidate_id_number, limit: 9
      t.index :fec_candidate_id_number

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    create_table :fec_filing_f3ps do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f3ps
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.date :date_general_election
      t.date :date_day_after_general_election
      t.decimal :net_contributions, precision: 12, scale: 2
      t.decimal :net_expenditures, precision: 12, scale: 2
      t.decimal :federal_funds, precision: 12, scale: 2
      t.decimal :a_i_individuals_itemized, precision: 12, scale: 2
      t.decimal :a_ii_individuals_unitemized, precision: 12, scale: 2
      t.decimal :a_iii_individual_contribution_total, precision: 12, scale: 2
      t.decimal :b_political_party_committees, precision: 12, scale: 2
      t.decimal :c_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :d_the_candidate, precision: 12, scale: 2
      t.decimal :e_total_contributions_other_than_loans, precision: 12, scale: 2
      t.decimal :transfers_from_aff_other_party_committees, precision: 12, scale: 2
      t.decimal :a_received_from_or_guaranteed_by_candidate, precision: 12, scale: 2
      t.decimal :b_other_loans, precision: 12, scale: 2
      t.decimal :c_total_loans, precision: 12, scale: 2
      t.decimal :a_operating, precision: 12, scale: 2
      t.decimal :b_fundraising, precision: 12, scale: 2
      t.decimal :c_legal_and_accounting, precision: 12, scale: 2
      t.decimal :d_total_offsets_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :other_receipts, precision: 12, scale: 2
      t.decimal :total_receipts, precision: 12, scale: 2
      t.decimal :operating_expenditures, precision: 12, scale: 2
      t.decimal :transfers_to_other_authorized_committees, precision: 12, scale: 2
      t.decimal :fundraising_disbursements, precision: 12, scale: 2
      t.decimal :exempt_legal_and_accounting_disbursements, precision: 12, scale: 2
      t.decimal :a_made_or_guaranteed_by_the_candidate, precision: 12, scale: 2
      t.decimal :b_other_repayments, precision: 12, scale: 2
      t.decimal :c_total_loan_repayments_made, precision: 12, scale: 2
      t.decimal :a_individuals, precision: 12, scale: 2
      t.decimal :c_other_political_committees, precision: 12, scale: 2
      t.decimal :d_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :other_disbursements, precision: 12, scale: 2
      t.decimal :total_disbursements, precision: 12, scale: 2
      t.decimal :alabama, precision: 12, scale: 2
      t.decimal :alaska, precision: 12, scale: 2
      t.decimal :arizona, precision: 12, scale: 2
      t.decimal :arkansas, precision: 12, scale: 2
      t.decimal :california, precision: 12, scale: 2
      t.decimal :colorado, precision: 12, scale: 2
      t.decimal :connecticut, precision: 12, scale: 2
      t.decimal :delaware, precision: 12, scale: 2
      t.decimal :dist_of_columbia, precision: 12, scale: 2
      t.decimal :florida, precision: 12, scale: 2
      t.decimal :georgia, precision: 12, scale: 2
      t.decimal :hawaii, precision: 12, scale: 2
      t.decimal :idaho, precision: 12, scale: 2
      t.decimal :illinois, precision: 12, scale: 2
      t.decimal :indiana, precision: 12, scale: 2
      t.decimal :iowa, precision: 12, scale: 2
      t.decimal :kansas, precision: 12, scale: 2
      t.decimal :kentucky, precision: 12, scale: 2
      t.decimal :louisiana, precision: 12, scale: 2
      t.decimal :maine, precision: 12, scale: 2
      t.decimal :maryland, precision: 12, scale: 2
      t.decimal :massachusetts, precision: 12, scale: 2
      t.decimal :michigan, precision: 12, scale: 2
      t.decimal :minnesota, precision: 12, scale: 2
      t.decimal :mississippi, precision: 12, scale: 2
      t.decimal :missouri, precision: 12, scale: 2
      t.decimal :montana, precision: 12, scale: 2
      t.decimal :nebraska, precision: 12, scale: 2
      t.decimal :nevada, precision: 12, scale: 2
      t.decimal :new_hampshire, precision: 12, scale: 2
      t.decimal :new_jersey, precision: 12, scale: 2
      t.decimal :new_mexico, precision: 12, scale: 2
      t.decimal :new_york, precision: 12, scale: 2
      t.decimal :north_carolina, precision: 12, scale: 2
      t.decimal :north_dakota, precision: 12, scale: 2
      t.decimal :ohio, precision: 12, scale: 2
      t.decimal :oklahoma, precision: 12, scale: 2
      t.decimal :oregon, precision: 12, scale: 2
      t.decimal :pennsylvania, precision: 12, scale: 2
      t.decimal :rhode_island, precision: 12, scale: 2
      t.decimal :south_carolina, precision: 12, scale: 2
      t.decimal :south_dakota, precision: 12, scale: 2
      t.decimal :tennessee, precision: 12, scale: 2
      t.decimal :texas, precision: 12, scale: 2
      t.decimal :utah, precision: 12, scale: 2
      t.decimal :vermont, precision: 12, scale: 2
      t.decimal :virginia, precision: 12, scale: 2
      t.decimal :washington, precision: 12, scale: 2
      t.decimal :west_virginia, precision: 12, scale: 2
      t.decimal :wisconsin, precision: 12, scale: 2
      t.decimal :wyoming, precision: 12, scale: 2
      t.decimal :puerto_rico, precision: 12, scale: 2
      t.decimal :guam, precision: 12, scale: 2
      t.decimal :virgin_islands, precision: 12, scale: 2
      t.decimal :totals, precision: 12, scale: 2
    end

    # F3P31 (Items to be Liquidated)

    create_table :fec_filing_f3s do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f3s
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.date :date_general_election
      t.date :date_day_after_general_election
      t.decimal :a_total_contributions_no_loans, precision: 12, scale: 2
      t.decimal :b_total_contribution_refunds, precision: 12, scale: 2
      t.decimal :c_net_contributions, precision: 12, scale: 2
      t.decimal :a_total_operating_expenditures, precision: 12, scale: 2
      t.decimal :b_total_offsets_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :c_net_operating_expenditures, precision: 12, scale: 2
      t.decimal :a_i_individuals_itemized, precision: 12, scale: 2
      t.decimal :a_ii_individuals_unitemized, precision: 12, scale: 2
      t.decimal :a_iii_individuals_total, precision: 12, scale: 2
      t.decimal :b_political_party_committees, precision: 12, scale: 2
      t.decimal :c_all_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :d_the_candidate, precision: 12, scale: 2
      t.decimal :e_total_contributions, precision: 12, scale: 2
      t.decimal :transfers_from_other_auth_committees, precision: 12, scale: 2
      t.decimal :a_loans_made_or_guarn_by_the_candidate, precision: 12, scale: 2
      t.decimal :b_all_other_loans, precision: 12, scale: 2
      t.decimal :c_total_loans, precision: 12, scale: 2
      t.decimal :offsets_to_operating_expenditures, precision: 12, scale: 2
      t.decimal :other_receipts, precision: 12, scale: 2
      t.decimal :total_receipts, precision: 12, scale: 2
      t.decimal :operating_expenditures, precision: 12, scale: 2
      t.decimal :transfers_to_other_auth_committees, precision: 12, scale: 2
      t.decimal :a_loan_repayment_by_candidate, precision: 12, scale: 2
      t.decimal :b_loan_repayments_all_other_loans, precision: 12, scale: 2
      t.decimal :c_total_loan_repayments, precision: 12, scale: 2
      t.decimal :a_refund_individuals_other_than_pol_cmtes, precision: 12, scale: 2
      t.decimal :b_refund_political_party_committees, precision: 12, scale: 2
      t.decimal :c_refund_other_political_committees, precision: 12, scale: 2
      t.decimal :d_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :other_disbursements, precision: 12, scale: 2
      t.decimal :total_disbursements, precision: 12, scale: 2
    end

    # report of receipts & disbursements - non-authorized committee
    create_table :fec_filing_f3x do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f3x$)|(^f3x[ant])
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :report_code, limit: 3
      t.string :election_code, limit: 5
      t.date :date_of_election
      t.string :state_of_election, limit: 2
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :qualified_committee, limit: 1
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.decimal :col_a_cash_on_hand_beginning_period, precision: 12, scale: 2
      t.decimal :col_a_total_receipts, precision: 12, scale: 2
      t.decimal :col_a_subtotal, precision: 12, scale: 2
      t.decimal :col_a_total_disbursements, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_a_debts_to, precision: 12, scale: 2
      t.decimal :col_a_debts_by, precision: 12, scale: 2
      t.decimal :col_a_individuals_itemized, precision: 12, scale: 2
      t.decimal :col_a_individuals_unitemized, precision: 12, scale: 2
      t.decimal :col_a_individual_contribution_total, precision: 12, scale: 2
      t.decimal :col_a_political_party_committees, precision: 12, scale: 2
      t.decimal :col_a_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :col_a_total_contributions, precision: 12, scale: 2
      t.decimal :col_a_transfers_from_aff_other_party_cmttees, precision: 12, scale: 2
      t.decimal :col_a_total_loans, precision: 12, scale: 2
      t.decimal :col_a_total_loan_repayments_received, precision: 12, scale: 2
      t.decimal :col_a_offsets_to_expenditures, precision: 12, scale: 2
      t.decimal :col_a_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_a_other_federal_receipts, precision: 12, scale: 2
      t.decimal :col_a_transfers_from_nonfederal_h3, precision: 12, scale: 2
      t.decimal :col_a_levin_funds, precision: 12, scale: 2
      t.decimal :col_a_total_nonfederal_transfers, precision: 12, scale: 2
      t.decimal :col_a_total_federal_receipts, precision: 12, scale: 2
      t.decimal :col_a_shared_operating_expenditures_federal, precision: 12, scale: 2
      t.decimal :col_a_shared_operating_expenditures_nonfederal, precision: 12, scale: 2
      t.decimal :col_a_other_federal_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_total_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_transfers_to_affiliated, precision: 12, scale: 2
      t.decimal :col_a_contributions_to_candidates, precision: 12, scale: 2
      t.decimal :col_a_independent_expenditures, precision: 12, scale: 2
      t.decimal :col_a_coordinated_expenditures_by_party_committees, precision: 12, scale: 2
      t.decimal :col_a_total_loan_repayments_made, precision: 12, scale: 2
      t.decimal :col_a_loans_made, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_individuals, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_party_committees, precision: 12, scale: 2
      t.decimal :col_a_refunds_to_other_committees, precision: 12, scale: 2
      t.decimal :col_a_total_refunds, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements, precision: 12, scale: 2
      t.decimal :col_a_federal_election_activity_federal_share, precision: 12, scale: 2
      t.decimal :col_a_federal_election_activity_levin_share, precision: 12, scale: 2
      t.decimal :col_a_federal_election_activity_all_federal, precision: 12, scale: 2
      t.decimal :col_a_federal_election_activity_total, precision: 12, scale: 2
      t.decimal :col_a_total_federal_disbursements, precision: 12, scale: 2
      t.decimal :col_a_net_contributions, precision: 12, scale: 2
      t.decimal :col_a_total_federal_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_a_total_offsets_to_expenditures, precision: 12, scale: 2
      t.decimal :col_a_net_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_cash_on_hand_jan_1, precision: 12, scale: 2
      t.integer :col_b_year, unsigned: true
      t.decimal :col_b_total_receipts, precision: 12, scale: 2
      t.decimal :col_b_subtotal, precision: 12, scale: 2
      t.decimal :col_b_total_disbursements, precision: 12, scale: 2
      t.decimal :col_b_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_b_individuals_itemized, precision: 12, scale: 2
      t.decimal :col_b_individuals_unitemized, precision: 12, scale: 2
      t.decimal :col_b_individual_contribution_total, precision: 12, scale: 2
      t.decimal :col_b_political_party_committees, precision: 12, scale: 2
      t.decimal :col_b_other_political_committees_pacs, precision: 12, scale: 2
      t.decimal :col_b_total_contributions, precision: 12, scale: 2
      t.decimal :col_b_transfers_from_aff_other_party_cmttees, precision: 12, scale: 2
      t.decimal :col_b_total_loans, precision: 12, scale: 2
      t.decimal :col_b_total_loan_repayments_received, precision: 12, scale: 2
      t.decimal :col_b_offsets_to_expenditures, precision: 12, scale: 2
      t.decimal :col_b_total_contributions_refunds, precision: 12, scale: 2
      t.decimal :col_b_other_federal_receipts, precision: 12, scale: 2
      t.decimal :col_b_transfers_from_nonfederal_h3, precision: 12, scale: 2
      t.decimal :col_b_levin_funds, precision: 12, scale: 2
      t.decimal :col_b_total_nonfederal_transfers, precision: 12, scale: 2
      t.decimal :col_b_total_federal_receipts, precision: 12, scale: 2
      t.decimal :col_b_shared_operating_expenditures_federal, precision: 12, scale: 2
      t.decimal :col_b_shared_operating_expenditures_nonfederal, precision: 12, scale: 2
      t.decimal :col_b_other_federal_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_total_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_transfers_to_affiliated, precision: 12, scale: 2
      t.decimal :col_b_contributions_to_candidates, precision: 12, scale: 2
      t.decimal :col_b_independent_expenditures, precision: 12, scale: 2
      t.decimal :col_b_coordinated_expenditures_by_party_committees, precision: 12, scale: 2
      t.decimal :col_b_total_loan_repayments_made, precision: 12, scale: 2
      t.decimal :col_b_loans_made, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_individuals, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_party_committees, precision: 12, scale: 2
      t.decimal :col_b_refunds_to_other_committees, precision: 12, scale: 2
      t.decimal :col_b_total_refunds, precision: 12, scale: 2
      t.decimal :col_b_other_disbursements, precision: 12, scale: 2
      t.decimal :col_b_federal_election_activity_federal_share, precision: 12, scale: 2
      t.decimal :col_b_federal_election_activity_levin_share, precision: 12, scale: 2
      t.decimal :col_b_federal_election_activity_all_federal, precision: 12, scale: 2
      t.decimal :col_b_federal_election_activity_total, precision: 12, scale: 2
      t.decimal :col_b_total_federal_disbursements, precision: 12, scale: 2
      t.decimal :col_b_net_contributions, precision: 12, scale: 2
      t.decimal :col_b_total_federal_operating_expenditures, precision: 12, scale: 2
      t.decimal :col_b_total_offsets_to_expenditures, precision: 12, scale: 2
      t.decimal :col_b_net_operating_expenditures, precision: 12, scale: 2

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

    end

    # report of contributions bundled by lobbyist/registrants and lobbyist/registrant PACs
    create_table :fec_filing_f3l do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f3l[a|n]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :election_state, limit: 2
      t.string :election_district, limit: 2
      t.string :report_code, limit: 3
      t.date :election_date
      t.string :semi_annual_period, limit: 1
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :semi_annual_period_jan_june, limit: 1
      t.string :semi_annual_period_jul_dec, limit: 1
      t.decimal :quarterly_monthly_bundled_contributions, precision: 12, scale: 2
      t.decimal :semi_annual_bundled_contributions, precision: 12, scale: 2
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
    end

    # report of receipts & disbursements - convention committee
    create_table :fec_filing_f4 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f4[na]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :committee_type, limit: 1
      t.string :committee_type_description, limit: 40
      t.string :report_code, limit: 3
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.decimal :col_a_cash_on_hand_beginning_reporting_period, precision: 12, scale: 2
      t.decimal :col_a_total_receipts, precision: 12, scale: 2
      t.decimal :col_a_subtotal, precision: 12, scale: 2
      t.decimal :col_a_total_disbursements, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_a_debts_to, precision: 12, scale: 2
      t.decimal :col_a_debts_by, precision: 12, scale: 2
      t.decimal :col_a_convention_expenditures, precision: 12, scale: 2
      t.decimal :col_a_convention_refunds, precision: 12, scale: 2
      t.decimal :col_a_expenditures_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_a_prior_expenditures_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_a_federal_funds, precision: 12, scale: 2
      t.decimal :col_a_contributions_itemized, precision: 12, scale: 2
      t.decimal :col_a_contributions_unitemized, precision: 12, scale: 2
      t.decimal :col_a_contributions_subtotal, precision: 12, scale: 2
      t.decimal :col_b_transfers_from_affiliated, precision: 12, scale: 2
      t.decimal :col_a_loans_received, precision: 12, scale: 2
      t.decimal :col_a_loan_repayments_received, precision: 12, scale: 2
      t.decimal :col_a_loan_receipts_subtotal, precision: 12, scale: 2
      t.decimal :col_a_convention_refunds_itemized, precision: 12, scale: 2
      t.decimal :col_a_convention_refunds_unitemized, precision: 12, scale: 2
      t.decimal :col_a_convention_refunds_subtotal, precision: 12, scale: 2
      t.decimal :col_a_other_refunds_itemized, precision: 12, scale: 2
      t.decimal :col_a_other_refunds_unitemized, precision: 12, scale: 2
      t.decimal :col_a_other_refunds_subtotal, precision: 12, scale: 2
      t.decimal :col_a_other_income_itemized, precision: 12, scale: 2
      t.decimal :col_a_other_income_unitemized, precision: 12, scale: 2
      t.decimal :col_a_other_income_subtotal, precision: 12, scale: 2
      t.decimal :col_a_convention_expenses_itemized, precision: 12, scale: 2
      t.decimal :col_a_convention_expenses_unitemized, precision: 12, scale: 2
      t.decimal :col_a_convention_expenses_subtotal, precision: 12, scale: 2
      t.decimal :col_a_transfers_to_affiliated, precision: 12, scale: 2
      t.decimal :col_a_loans_made, precision: 12, scale: 2
      t.decimal :col_a_loan_repayments_made, precision: 12, scale: 2
      t.decimal :col_a_loan_disbursements_subtotal, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements_itemized, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements_unitemized, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements_subtotal, precision: 12, scale: 2
      t.integer :col_b_cash_on_hand_beginning_year, unsigned: true
      t.integer :col_b_beginning_year, unsigned: true
      t.decimal :col_b_total_receipts, precision: 12, scale: 2
      t.decimal :col_b_subtotal, precision: 12, scale: 2
      t.decimal :col_b_total_disbursements, precision: 12, scale: 2
      t.decimal :col_b_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_b_convention_expenditures, precision: 12, scale: 2
      t.decimal :col_b_convention_refunds, precision: 12, scale: 2
      t.decimal :col_b_expenditures_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_b_prior_expendiutres_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_b_total_expenditures_subject_to_limits, precision: 12, scale: 2
      t.decimal :col_b_federal_funds, precision: 12, scale: 2
      t.decimal :col_b_contributions_subtotal, precision: 12, scale: 2
      t.decimal :col_b_loan_receipts_subtotal, precision: 12, scale: 2
      t.decimal :col_b_convention_refunds_subtotal, precision: 12, scale: 2
      t.decimal :col_b_other_refunds_subtotal, precision: 12, scale: 2
      t.decimal :col_b_other_income_subtotal, precision: 12, scale: 2
      t.decimal :col_b_convention_expenses_subtotal, precision: 12, scale: 2
      t.decimal :col_b_transfers_to_affiliated, precision: 12, scale: 2
      t.decimal :col_b_loan_disbursements_subtotal, precision: 12, scale: 2
      t.decimal :col_b_other_disbursements_subtotal, precision: 12, scale: 2
      t.decimal :col_a_total_expenditures_subject_to_limits, precision: 12, scale: 2

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

    end

    # report of independent expenditures made & contributions received
    create_table :fec_filing_f5 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f5[na]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :entity_type, limit: 3
      t.string :organization_name, limit: 200
      t.index :organization_name

      t.string :individual_last_name, limit: 30
      t.string :individual_first_name, limit: 20
      t.string :individual_middle_name, limit: 20
      t.string :individual_prefix, limit: 10
      t.string :individual_suffix, limit: 10
      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :individual_occupation, limit: 38
      t.string :individual_employer, limit: 38
      t.string :report_code, limit: 3
      t.string :report_type, limit: 3
      t.date :original_amendment_date
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.decimal :total_contribution, precision: 12, scale: 2
      t.decimal :total_independent_expenditure, precision: 12, scale: 2
      t.string :person_completing_last_name, limit: 30
      t.string :person_completing_first_name, limit: 20
      t.string :person_completing_middle_name, limit: 20
      t.string :person_completing_prefix, limit: 10
      t.string :person_completing_suffix, limit: 10
      t.date :date_signed

      t.string :qualified_nonprofit, limit: 1
      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :person_completing_name, limit: 200
      t.index :person_completing_name

      t.string :report_pgi, limit: 5
      t.date :election_date
      t.string :election_state, limit: 2
      t.date :date_notarized
      t.date :date_notary_commission_expires
      t.string :notary_name, limit: 200
      t.index :notary_name

    end

    # F56 (Contributions for Independent Expenditures)
    create_table :fec_filing_f56 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f56
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip_code, limit: 9
      t.string :contributor_fec_id, limit: 9
      t.date :contribution_date
      t.decimal :contribution_amount, precision: 12, scale: 2
      t.string :contributor_employer, limit: 38
      t.string :contributor_occupation, limit: 38

      t.string :contributor_name, limit: 200
      t.index :contributor_name

      t.string :candidate_id, limit: 9
      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    # F57 (Independent Expenditures)
    create_table :fec_filing_f57 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f57
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :dissemination_date
      t.decimal :expenditure_amount, precision: 12, scale: 2
      t.decimal :calendar_y_t_d_per_election_office, precision: 12, scale: 2
      t.string :expenditure_purpose_descrip, limit: 100
      t.string :category_code, limit: 3
      t.string :payee_cmtte_fec_id_number, limit: 9
      t.index :payee_cmtte_fec_id_number

      t.string :support_oppose_code, limit: 1
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2

      t.string :expenditure_purpose_code, limit: 3
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :amended_code, limit: 1
    end

    # 48 hour notice of contributions/loans received
    create_table :fec_filing_f6 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # (^f6$)|(^f6[an])
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.date :original_amendment_date
      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :signer_last_name, limit: 30
      t.string :signer_first_name, limit: 20
      t.string :signer_middle_name, limit: 20
      t.string :signer_prefix, limit: 10
      t.string :signer_suffix, limit: 10
      t.date :date_signed

      t.string :candidate_name, limit: 200
      t.index :candidate_name

    end

    # F65 (Contributions for 48 Hour Notices)
    create_table :fec_filing_f65 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f65
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip_code, limit: 9
      t.string :contributor_fec_id, limit: 9
      t.date :contribution_date
      t.decimal :contribution_amount, precision: 12, scale: 2
      t.string :contributor_employer, limit: 38
      t.string :contributor_occupation, limit: 38

      t.string :contributor_name, limit: 200
      t.index :contributor_name

      t.string :candidate_id, limit: 9
      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    # report of communication costs - corporations and membership organizations
    create_table :fec_filing_f7 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f7[na]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :organization_name, limit: 200
      t.index :organization_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :organization_type, limit: 1
      t.string :report_code, limit: 3
      t.date :election_date
      t.string :election_state, limit: 2
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.decimal :total_costs, precision: 12, scale: 2
      t.string :person_designated_last_name, limit: 30
      t.string :person_designated_first_name, limit: 20
      t.string :person_designated_middle_name, limit: 20
      t.string :person_designated_prefix, limit: 10
      t.string :person_designated_suffix, limit: 10
      t.string :person_designated_title, limit: 20
      t.date :date_signed

      t.string :person_designated_name, limit: 200
      t.index :person_designated_name

    end

    create_table :fec_filing_f76 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f76
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :communication_type, limit: 2
      t.string :communication_type_description, limit: 40
      t.string :communication_class, limit: 1
      t.date :communication_date
      t.decimal :communication_cost, precision: 12, scale: 2
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.string :support_oppose_code, limit: 1
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2

      t.string :candidate_name, limit: 200
      t.index :candidate_name

    end

    # debt settlement plan
    # create_table :fec_filing_f8 do |t|
    #   t.string :fec_id, :limit => 9, :null => false
    #   t.integer :lock_version, :default => 0, unsigned: true
    #   t.timestamps
    # end

    # 24 hour notice of disbursement/obligations for electioneering communications
    create_table :fec_filing_f9 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f9
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :entity_type, limit: 3
      t.string :organization_name, limit: 200
      t.index :organization_name

      t.string :individual_last_name, limit: 30
      t.string :individual_first_name, limit: 20
      t.string :individual_middle_name, limit: 20
      t.string :individual_prefix, limit: 10
      t.string :individual_suffix, limit: 10
      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :individual_employer, limit: 38
      t.string :individual_occupation, limit: 38
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.date :date_public_distribution
      t.string :communication_title, limit: 40
      t.string :filer_code, limit: 3
      t.string :filer_code_description, limit: 20
      t.string :segregated_bank_account, limit: 1
      t.string :custodian_last_name, limit: 30
      t.string :custodian_first_name, limit: 20
      t.string :custodian_middle_name, limit: 20
      t.string :custodian_prefix, limit: 10
      t.string :custodian_suffix, limit: 10
      t.string :custodian_street_1, limit: 34
      t.string :custodian_street_2, limit: 34
      t.string :custodian_city, limit: 30
      t.string :custodian_state, limit: 2
      t.string :custodian_zip_code, limit: 9
      t.string :custodian_employer, limit: 38
      t.string :custodian_occupation, limit: 38
      t.decimal :total_donations, precision: 12, scale: 2
      t.decimal :total_disbursements, precision: 12, scale: 2
      t.string :person_completing_last_name, limit: 30
      t.string :person_completing_first_name, limit: 20
      t.string :person_completing_middle_name, limit: 20
      t.string :person_completing_prefix, limit: 10
      t.string :person_completing_suffix, limit: 10
      t.date :date_signed

      t.string :qualified_non_profit, limit: 1
    end

    # 24 hour notice of expenditure from candidate's personal funds
    # create_table :fec_filing_f10 do |t|
    #   t.integer :fec_record_number, null: false, unsigned: true
    #   t.integer :row_number, null: false, unsigned: true
    #   t.integer :lock_version, null: false, default: 0, unsigned: true
    #   t.timestamps
    #   t.index [:fec_record_number, :row_number], unique: true
    # end

    # report of donations accepted for inaugural committee
    create_table :fec_filing_f13 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f13[an]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :change_of_address, limit: 1
      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :report_code, limit: 3
      t.date :amendment_date
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.decimal :total_donations_accepted, precision: 12, scale: 2
      t.decimal :total_donations_refunded, precision: 12, scale: 2
      t.decimal :net_donations, precision: 12, scale: 2
      t.string :designated_last_name, limit: 30
      t.string :designated_first_name, limit: 20
      t.string :designated_middle_name, limit: 20
      t.string :designated_prefix, limit: 10
      t.string :designated_suffix, limit: 10
      t.date :date_signed
    end

    create_table :fec_filing_f132 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f132
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip, limit: 9
      t.date :donation_date
      t.decimal :donation_amount, precision: 12, scale: 2
      t.decimal :donation_aggregate_amount, precision: 12, scale: 2
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100
    end

    create_table :fec_filing_f133 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f133
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip, limit: 9
      t.date :refund_date
      t.decimal :refund_amount, precision: 12, scale: 2
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100
    end

    # F91 (Lists of Persons Exercising Control)
    create_table :fec_filing_f91 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f91
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :controller_last_name, limit: 30
      t.string :controller_first_name, limit: 20
      t.string :controller_middle_name, limit: 20
      t.string :controller_prefix, limit: 10
      t.string :controller_suffix, limit: 10
      t.string :controller_street_1, limit: 34
      t.string :controller_street_2, limit: 34
      t.string :controller_city, limit: 30
      t.string :controller_state, limit: 2
      t.string :controller_zip_code, limit: 9
      t.string :controller_employer, limit: 38
      t.string :controller_occupation, limit: 38

      t.string :amended_cd, limit: 1
    end

    # F92 (Contributions for Electioneering Communications)
    create_table :fec_filing_f92 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f92
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip_code, limit: 9
      t.date :contribution_date
      t.decimal :contribution_amount, precision: 12, scale: 2

      t.string :contributor_employer, limit: 38
      t.string :contributor_occupation, limit: 38
      t.string :transaction_type, limit: 3
    end

    # F93 (Expenditures for Electioneering Communications)
    create_table :fec_filing_f93 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f93
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :expenditure_date
      t.decimal :expenditure_amount, precision: 12, scale: 2
      t.string :expenditure_purpose_descrip, limit: 100
      t.string :payee_employer, limit: 38
      t.string :payee_occupation, limit: 38
      t.date :communication_date

      t.string :expenditure_purpose_code, limit: 3
    end

    # F94 (Federal Candidates List for Electioneering Communications)
    create_table :fec_filing_f94 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f94
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20

      t.string :candidate_name, limit: 200
      t.index :candidate_name

    end

    # miscellaneous text
    create_table :fec_filing_f99 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^f99
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :committee_name, limit: 200
      t.index :committee_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.string :text_code, limit: 3
      t.text :text

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

    end

    # H1 (Method of Allocation for Federal/Non-Federal Activity)
    create_table :fec_filing_h1 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h1
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :presidential_only_election_year, limit: 1
      t.string :presidential_senate_election_year, limit: 1
      t.string :senate_only_election_year, limit: 1
      t.string :non_presidential_non_senate_election_year, limit: 1
      t.string :flat_minimum_federal_percentage, limit: 1
      t.integer :federal_percent, unsigned: true
      t.integer :nonfederal_percent, unsigned: true
      t.string :administrative_ratio_applies, limit: 1
      t.string :generic_voter_drive_ratio_applies, limit: 1
      t.string :public_communications_referencing_party_ratio_applies, limit: 1

      t.integer :national_party_committee_percentage, unsigned: true
    #   t.integer :house_senate_party_committees_minimum_federal_percentage, unsigned: true
      t.integer :hsp_committees_minimum_federal_percentage, unsigned: true
      # FIXME: mysql only allows identifiers of 64 char; this is too long :(
    #   t.integer :house_senate_party_committees_percentage_federal_candidate_support, unsigned: true
      t.integer :hsp_committees_percentage_federal_candidate_support, unsigned: true
    #   t.integer :house_senate_party_committees_percentage_nonfederal_candidate_support, unsigned: true
      t.integer :hsp_committees_percentage_nonfederal_candidate_support, unsigned: true
    #   t.integer :house_senate_party_committees_percentage_nonfederal_candidate_support, unsigned: true
      t.integer :hsp_committees_percentage_nonfederal_candidate_support, unsigned: true
    #   t.decimal :house_senate_party_committees_actual_federal_candidate_support, precision: 12, scale: 2
      t.decimal :hsp_committees_actual_federal_candidate_support, precision: 12, scale: 2
    #   t.decimal :house_senate_party_committees_actual_nonfederal_candidate_support, precision: 12, scale: 2
      t.decimal :hsp_committees_actual_nonfederal_candidate_support, precision: 12, scale: 2
    #   t.integer :house_senate_party_committees_percentage_actual_federal, unsigned: true
      t.integer :hsp_committees_percentage_actual_federal, unsigned: true
      t.decimal :actual_direct_candidate_support_federal, precision: 12, scale: 2
      t.decimal :actual_direct_candidate_support_nonfederal, precision: 12, scale: 2
      t.decimal :actual_direct_candidate_support_federal_percent, precision: 12, scale: 2
      t.integer :ballot_presidential
      t.integer :ballot_senate
      t.integer :ballot_house
      t.integer :subtotal_federal
      t.integer :ballot_governor
      t.integer :ballot_other_statewide
      t.integer :ballot_state_senate
      t.integer :ballot_state_representative
      t.integer :ballot_local_candidates
      t.integer :extra_nonfederal_point
      t.integer :subtotal
      t.integer :total_points
    end

    # H2 (Federal/Non-Federal Allocation Ratios)
    create_table :fec_filing_h2 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h2
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :activity_event_name, limit: 90
      t.string :direct_fundraising, limit: 1
      t.string :direct_candidate_support, limit: 1
      t.string :ratio_code, limit: 1
      t.integer :federal_percentage, unsigned: true
      t.integer :nonfederal_percentage, unsigned: true

      t.string :exempt_activity, limit: 1
    end

    # H3 (Transfers from Non-Federal Accounts)
    create_table :fec_filing_h3 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h3
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :account_name, limit: 90
      t.string :event_type, limit: 2
      t.string :event_activity_name, limit: 90
      t.date :receipt_date
      t.decimal :total_amount_transferred, precision: 12, scale: 2
      t.decimal :transferred_amount, precision: 12, scale: 2
    end

    # H4 (Disbursements for Allocated Federal/Non-Federal Activity)
    create_table :fec_filing_h4 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h4
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :account_identifier, limit: 90
      t.date :expenditure_date
      t.decimal :total_amount, precision: 12, scale: 2
      t.decimal :federal_share, precision: 12, scale: 2
      t.decimal :nonfederal_share, precision: 12, scale: 2
      t.decimal :event_year_to_date, precision: 12, scale: 2
      t.string :expenditure_purpose_description, limit: 100
      t.string :category_code, limit: 3
      t.string :administrative_voter_drive_activity, limit: 1
      t.string :fundraising_activity, limit: 1
      t.string :exempt_activity, limit: 1
      t.string :generic_voter_drive_activity, limit: 1
      t.string :direct_candidate_support_activity, limit: 1
      t.string :public_communications_party_activity, limit: 1
      t.string :memo_code, limit: 1
      t.string :memo_text, limit: 100

      t.string :expenditure_purpose_code, limit: 3
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :fec_committee_id_number, limit: 9
      t.index :fec_committee_id_number

      t.string :fec_candidate_id_number, limit: 9
      t.index :fec_candidate_id_number

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :amended_cd, limit: 1
    end

    # H5 (Transfers from Levin Funds)
    create_table :fec_filing_h5 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h5
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :account_name, limit: 90
      t.date :receipt_date
      t.decimal :total_amount_transferred, precision: 12, scale: 2
      t.decimal :voter_registration_amount, precision: 12, scale: 2
      t.decimal :voter_id_amount, precision: 12, scale: 2
      t.decimal :gotv_amount, precision: 12, scale: 2
      t.decimal :generic_campaign_amount, precision: 12, scale: 2
    end

    # H6 (Disbursements from Levin Funds)
    create_table :fec_filing_h6 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^h6
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :account_identifier, limit: 90
      t.date :expenditure_date
      t.decimal :total_amount, precision: 12, scale: 2
      t.decimal :federal_share, precision: 12, scale: 2
      t.decimal :levin_share, precision: 12, scale: 2
      t.decimal :event_year_to_date, precision: 12, scale: 2
      t.string :expenditure_purpose_description, limit: 100
      t.string :category_code, limit: 3
      t.string :voter_registration_activity, limit: 1
      t.string :gotv_activity, limit: 1
      t.string :voter_id_activity, limit: 1
      t.string :generic_campaign_activity, limit: 1
      t.string :memo_code, limit: 1
      t.string :memo_text, limit: 100

      t.string :expenditure_purpose_code, limit: 3
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :fec_committee_id_number, limit: 9
      t.index :fec_committee_id_number

      t.string :fec_candidate_id_number, limit: 9
      t.index :fec_candidate_id_number

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_committee_id, limit: 9
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    # SA (Contributions)
    create_table :fec_filing_sa do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sa
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :contributor_organization_name, limit: 200
      t.index :contributor_organization_name

      t.string :contributor_last_name, limit: 30
      t.string :contributor_first_name, limit: 20
      t.string :contributor_middle_name, limit: 20
      t.string :contributor_prefix, limit: 10
      t.string :contributor_suffix, limit: 10
      t.string :contributor_street_1, limit: 34
      t.string :contributor_street_2, limit: 34
      t.string :contributor_city, limit: 30
      t.string :contributor_state, limit: 2
      t.string :contributor_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :contribution_date
      t.decimal :contribution_amount, precision: 12, scale: 2
      t.decimal :contribution_aggregate, precision: 12, scale: 2
      t.string :contribution_purpose_descrip, limit: 100
      t.string :contributor_employer, limit: 38
      t.string :contributor_occupation, limit: 38
      t.string :donor_committee_fec_id, limit: 9
      t.string :donor_committee_name, limit: 200
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
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street1, limit: 34
      t.string :conduit_street2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100
      t.string :reference_code, limit: 9

      t.string :contribution_purpose_code, limit: 3
      t.string :increased_limit_code, limit: 3
      t.string :contributor_name, limit: 200
      t.index :contributor_name

      t.string :donor_candidate_name, limit: 200
      t.index :donor_candidate_name

    end

    # SB (Expenditures)
    create_table :fec_filing_sb do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sb
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :expenditure_date
      t.decimal :expenditure_amount, precision: 12, scale: 2
      t.decimal :semi_annual_refunded_bundled_amt, precision: 12, scale: 2
      t.string :expenditure_purpose_descrip, limit: 100
      t.string :category_code, limit: 3
      t.string :beneficiary_committee_fec_id, limit: 9
      t.string :beneficiary_committee_name, limit: 200
      t.index :beneficiary_committee_name

      t.string :beneficiary_candidate_fec_id, limit: 9
      t.string :beneficiary_candidate_last_name, limit: 30
      t.string :beneficiary_candidate_first_name, limit: 20
      t.string :beneficiary_candidate_middle_name, limit: 20
      t.string :beneficiary_candidate_prefix, limit: 10
      t.string :beneficiary_candidate_suffix, limit: 10
      t.string :beneficiary_candidate_office, limit: 1
      t.string :beneficiary_candidate_state, limit: 2
      t.string :beneficiary_candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100
      t.string :reference_to_si_or_sl_system_code_that_identifies_the_account, limit: 9

      t.string :expenditure_purpose_code, limit: 3
      t.string :refund_or_disposal_of_excess, limit: 1
      t.date :communication_date
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :beneficiary_candidate_name, limit: 200
      t.index :beneficiary_candidate_name

    end

    # SC (Loans)
    create_table :fec_filing_sc do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sc[^1-2]
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :receipt_line_number, limit: 8
      t.string :entity_type, limit: 3
      t.string :lender_organization_name, limit: 200
      t.index :lender_organization_name

      t.string :lender_last_name, limit: 30
      t.string :lender_first_name, limit: 20
      t.string :lender_middle_name, limit: 20
      t.string :lender_prefix, limit: 10
      t.string :lender_suffix, limit: 10
      t.string :lender_street_1, limit: 34
      t.string :lender_street_2, limit: 34
      t.string :lender_city, limit: 30
      t.string :lender_state, limit: 2
      t.string :lender_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.decimal :loan_amount_original, precision: 12, scale: 2
      t.decimal :loan_payment_to_date, precision: 12, scale: 2
      t.decimal :loan_balance, precision: 12, scale: 2
      t.integer :loan_incurred_date_terms
      t.string :loan_due_date_terms, limit: 15
      t.string :loan_interest_rate_terms, limit: 15
      t.string :secured, limit: 1
      t.string :personal_funds, limit: 1
      t.string :lender_committee_id_number, limit: 9
      t.index :lender_committee_id_number

      t.string :lender_candidate_id_number, limit: 9
      t.index :lender_candidate_id_number

      t.string :lender_candidate_last_name, limit: 30
      t.string :lender_candidate_first_name, limit: 20
      t.string :lender_candidate_middle_nm
      t.string :lender_candidate_prefix, limit: 10
      t.string :lender_candidate_suffix, limit: 10
      t.string :lender_candidate_office, limit: 1
      t.string :lender_candidate_state, limit: 2
      t.string :lender_candidate_district, limit: 2
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100

      t.string :lender_name, limit: 200
      t.index :lender_name

      t.string :lender_candidate_name, limit: 200
      t.index :lender_candidate_name

    end

    # SC1
    create_table :fec_filing_sc1 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sc1
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :lender_organization_name, limit: 200
      t.index :lender_organization_name

      t.string :lender_street_1, limit: 34
      t.string :lender_street_2, limit: 34
      t.string :lender_city, limit: 30
      t.string :lender_state, limit: 2
      t.string :lender_zip_code, limit: 9
      t.decimal :loan_amount, precision: 12, scale: 2
      t.string :loan_interest_rate, limit: 15
      t.date :loan_incurred_date
      t.string :loan_due_date, limit: 15 # TODO: Check. This is what the docs say, though.
      t.string :loan_restructured, limit: 1
      t.date :loan_inccured_date_original
      t.decimal :credit_amount_this_draw, precision: 12, scale: 2
      t.decimal :total_balance, precision: 12, scale: 2
      t.string :others_liable, limit: 1
      t.string :collateral, limit: 1
      t.string :description, limit: 100
      t.decimal :collateral_value_amount, precision: 12, scale: 2
      t.string :perfected_interest, limit: 1
      t.string :future_income, limit: 1
      t.decimal :estimated_value, precision: 12, scale: 2
      t.date :established_date
      t.string :account_location_name, limit: 200
      t.index :account_location_name

      t.string :street_1, limit: 34
      t.string :street_2, limit: 34
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 9
      t.date :deposit_acct_auth_date_presidential
      t.string :f_basis_of_loan_description
      t.string :treasurer_last_name, limit: 30
      t.string :treasurer_first_name, limit: 20
      t.string :treasurer_middle_name, limit: 20
      t.string :treasurer_prefix, limit: 10
      t.string :treasurer_suffix, limit: 10
      t.date :date_signed
      t.string :authorized_last_name, limit: 30
      t.string :authorized_first_name, limit: 20
      t.string :authorized_middle_name, limit: 20
      t.string :authorized_prefix, limit: 10
      t.string :authorized_suffix, limit: 10
      t.string :authorized_title, limit: 20
      t.string :entity_type, limit: 3

      t.string :treasurer_name, limit: 200
      t.index :treasurer_name

      t.string :authorized_name, limit: 200
      t.index :authorized_name

    end

    # SC2
    create_table :fec_filing_sc2 do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sc2
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :guarantor_last_name, limit: 30
      t.string :guarantor_first_name, limit: 20
      t.string :guarantor_middle_name, limit: 20
      t.string :guarantor_prefix, limit: 10
      t.string :guarantor_suffix, limit: 10
      t.string :guarantor_street_1, limit: 34
      t.string :guarantor_street_2, limit: 34
      t.string :guarantor_city, limit: 30
      t.string :guarantor_state, limit: 2
      t.string :guarantor_zip_code, limit: 9
      t.string :guarantor_employer, limit: 38
      t.string :guarantor_occupation, limit: 38
      t.decimal :guaranteed_amount, precision: 12, scale: 2

      t.string :guarantor_name, limit: 200
      t.index :guarantor_name

    end

    # SD (Debts & Obligations)
    create_table :fec_filing_sd do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sd
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :entity_type, limit: 3
      t.string :creditor_organization_name, limit: 200
      t.index :creditor_organization_name

      t.string :creditor_last_name, limit: 30
      t.string :creditor_first_name, limit: 20
      t.string :creditor_middle_name, limit: 20
      t.string :creditor_prefix, limit: 10
      t.string :creditor_suffix, limit: 10
      t.string :creditor_street_1, limit: 34
      t.string :creditor_street_2, limit: 34
      t.string :creditor_city, limit: 30
      t.string :creditor_state, limit: 2
      t.string :creditor_zip_code, limit: 9
      t.string :purpose_of_debt_or_obligation, limit: 100
      t.decimal :beginning_balance_this_period, precision: 12, scale: 2
      t.decimal :incurred_amount_this_period, precision: 12, scale: 2
      t.decimal :payment_amount_this_period, precision: 12, scale: 2
      t.decimal :balance_at_close_this_period, precision: 12, scale: 2

      t.string :creditor_name, limit: 200
      t.index :creditor_name

      t.string :fec_committee_id_number, limit: 9
      t.index :fec_committee_id_number

      t.string :fec_candidate_id_number, limit: 9
      t.index :fec_candidate_id_number

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :candidate_office, limit: 1
      t.string :candidate_state, limit: 2
      t.string :candidate_district, limit: 2
      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    # SE (Independent Expenditures)
    create_table :fec_filing_se do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^se
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.string :election_code, limit: 5
      t.string :election_other_description, limit: 20
      t.date :dissemination_date
      t.decimal :expenditure_amount, precision: 12, scale: 2
      t.date :disbursement_date
      t.decimal :calendar_y_t_d_per_election_office, precision: 12, scale: 2
      t.string :expenditure_purpose_descrip, limit: 100
      t.string :category_code, limit: 3
      t.string :payee_cmtte_fec_id_number, limit: 9
      t.index :payee_cmtte_fec_id_number

      t.string :support_oppose_code, limit: 1
      t.string :candidate_id_number, limit: 9
      t.index :candidate_id_number

      t.string :candidate_last_name, limit: 30
      t.string :candidate_first_name, limit: 20
      t.string :candidate_middle_name, limit: 20
      t.string :candidate_prefix, limit: 10
      t.string :candidate_suffix, limit: 10
      t.string :candidate_office, limit: 1
      t.string :candidate_district, limit: 2
      t.string :candidate_state, limit: 2
      t.string :completing_last_name, limit: 30
      t.string :completing_first_name, limit: 20
      t.string :completing_middle_name, limit: 20
      t.string :completing_prefix, limit: 10
      t.string :completing_suffix, limit: 10
      t.date :date_signed
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100

      t.string :expenditure_purpose_code, limit: 3
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :candidate_name, limit: 200
      t.index :candidate_name

      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
      t.string :ind_name_as_signed, limit: 200
      t.date :date_notarized
      t.date :date_notary_commission_expires
      t.string :ind_name_notary, limit: 200
    end

    # SF (Coordinated Expenditures)
    create_table :fec_filing_sf do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sf
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_name, limit: 8
      t.string :coordinated_expenditures, limit: 1
      t.string :designating_committee_id_number, limit: 9
      t.index :designating_committee_id_number

      t.string :designating_committee_name, limit: 200
      t.index :designating_committee_name

      t.string :subordinate_committee_id_number, limit: 9
      t.index :subordinate_committee_id_number

      t.string :subordinate_committee_name, limit: 200
      t.index :subordinate_committee_name

      t.string :subordinate_street_1, limit: 34
      t.string :subordinate_street_2, limit: 34
      t.string :subordinate_city, limit: 30
      t.string :subordinate_state, limit: 2
      t.string :subordinate_zip_code, limit: 9
      t.string :entity_type, limit: 3
      t.string :payee_organization_name, limit: 200
      t.index :payee_organization_name

      t.string :payee_last_name, limit: 30
      t.string :payee_first_name, limit: 20
      t.string :payee_middle_name, limit: 20
      t.string :payee_prefix, limit: 10
      t.string :payee_suffix, limit: 10
      t.string :payee_street_1, limit: 34
      t.string :payee_street_2, limit: 34
      t.string :payee_city, limit: 30
      t.string :payee_state, limit: 2
      t.string :payee_zip_code, limit: 9
      t.date :expenditure_date
      t.decimal :expenditure_amount, precision: 12, scale: 2
      t.decimal :aggregate_general_elec_expended, precision: 12, scale: 2
      t.string :expenditure_purpose_descrip, limit: 100
      t.string :category_code, limit: 3
      t.string :payee_committee_id_number, limit: 9
      t.index :payee_committee_id_number

      t.string :payee_candidate_id_number, limit: 9
      t.index :payee_candidate_id_number

      t.string :payee_candidate_last_name, limit: 30
      t.string :payee_candidate_first_name, limit: 20
      t.string :payee_candidate_middle_name, limit: 20
      t.string :payee_candidate_prefix, limit: 10
      t.string :payee_candidate_suffix, limit: 10
      t.string :payee_candidate_office, limit: 1
      t.string :payee_candidate_state, limit: 2
      t.string :payee_candidate_district, limit: 2
      t.string :memo_code, limit: 1
      t.string :memo_text_description, limit: 100

      t.string :expenditure_purpose_code, limit: 3
      t.string :increased_limit, limit: 3
      t.string :payee_name, limit: 200
      t.index :payee_name

      t.string :payee_candidate_name, limit: 200
      t.index :payee_candidate_name

      t.string :conduit_name, limit: 200
      t.index :conduit_name

      t.string :conduit_street_1, limit: 34
      t.string :conduit_street_2, limit: 34
      t.string :conduit_city, limit: 30
      t.string :conduit_state, limit: 2
      t.string :conduit_zip_code, limit: 9
    end

    # SL (Levin Fund Summary)
    create_table :fec_filing_sl do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^sl
      t.string :form_type, limit: 8
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :record_id_number, limit: 9
      t.index :record_id_number

      t.string :account_name, limit: 90
      t.date :coverage_from_date
      t.date :coverage_through_date
      t.decimal :col_a_itemized_receipts_persons, precision: 12, scale: 2
      t.decimal :col_a_unitemized_receipts_persons, precision: 12, scale: 2
      t.decimal :col_a_total_receipts_persons, precision: 12, scale: 2
      t.decimal :col_a_other_receipts, precision: 12, scale: 2
      t.decimal :col_a_total_receipts, precision: 12, scale: 2
      t.decimal :col_a_voter_registration_disbursements, precision: 12, scale: 2
      t.decimal :col_a_voter_id_disbursements, precision: 12, scale: 2
      t.decimal :col_a_gotv_disbursements, precision: 12, scale: 2
      t.decimal :col_a_generic_campaign_disbursements, precision: 12, scale: 2
      t.decimal :col_a_disbursements_subtotal, precision: 12, scale: 2
      t.decimal :col_a_other_disbursements, precision: 12, scale: 2
      t.decimal :col_a_total_disbursements, precision: 12, scale: 2
      t.decimal :col_a_cash_on_hand_beginning_period, precision: 12, scale: 2
      t.decimal :col_a_receipts_period, precision: 12, scale: 2
      t.decimal :col_a_subtotal_period, precision: 12, scale: 2
      t.decimal :col_b_disbursements_period, precision: 12, scale: 2
      t.decimal :col_b_cash_on_hand_close_of_period, precision: 12, scale: 2
      t.decimal :col_b_itemized_receipts_persons, precision: 12, scale: 2
      t.decimal :col_b_unitemized_receipts_persons, precision: 12, scale: 2
      t.decimal :col_b_total_receipts_persons, precision: 12, scale: 2
      t.decimal :col_b_other_receipts, precision: 12, scale: 2
      t.decimal :col_b_total_receipts, precision: 12, scale: 2
      t.decimal :col_b_voter_registration_disbursements, precision: 12, scale: 2
      t.decimal :col_b_voter_id_disbursements, precision: 12, scale: 2
      t.decimal :col_b_gotv_disbursements, precision: 12, scale: 2
      t.decimal :col_b_generic_campaign_disbursements, precision: 12, scale: 2
      t.decimal :col_b_disbursements_subtotal, precision: 12, scale: 2
      t.decimal :col_b_other_disbursements, precision: 12, scale: 2
      t.decimal :col_b_total_disbursements, precision: 12, scale: 2
      t.decimal :col_b_cash_on_hand_beginning_period, precision: 12, scale: 2
      t.decimal :col_b_receipts_period, precision: 12, scale: 2
      t.decimal :col_b_subtotal_period, precision: 12, scale: 2
    end

    create_table :fec_filing_text do |t|
      t.integer :fec_record_number, null: false, unsigned: true
      t.integer :row_number, null: false, unsigned: true
      t.integer :lock_version, null: false, default: 0, unsigned: true
      t.timestamps
      t.index [:fec_record_number, :row_number], unique: true

      # ^text
      t.string :form_type, limit: 8
      t.string :rec_type, limit: 4
      t.string :filer_committee_id_number, limit: 9
      t.index :filer_committee_id_number

      t.string :transaction_id_number, limit: 20
      t.string :back_reference_tran_id_number, limit: 20
      t.string :back_reference_sched_form_name, limit: 8
      t.text :text
    end
  end
end
