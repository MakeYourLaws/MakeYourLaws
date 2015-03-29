# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150329113203) do

  create_table "address_usages", force: true do |t|
    t.integer  "legal_identity_id", null: false
    t.integer  "address_id",        null: false
    t.string   "usage"
    t.date     "from"
    t.date     "to"
    t.datetime "confirmed"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "address_usages", ["address_id", "legal_identity_id"], name: "index_address_usages_on_address_id_and_legal_identity_id", using: :btree
  add_index "address_usages", ["legal_identity_id", "usage"], name: "index_address_usages_on_legal_identity_id_and_usage", using: :btree

  create_table "addresses", force: true do |t|
    t.string  "country",                     default: "United States", null: false
    t.string  "street_address_1", limit: 34
    t.string  "city",             limit: 30,                           null: false
    t.string  "state",            limit: 2,                            null: false
    t.integer "zip"
    t.float   "lat",              limit: 24
    t.float   "lng",              limit: 24
  end

  add_index "addresses", ["country", "state", "city"], name: "index_addresses_on_country_and_state_and_city", using: :btree
  add_index "addresses", ["lat", "lng"], name: "index_addresses_on_lat_and_lng", using: :btree

  create_table "bit_pay_invoices", force: true do |t|
    t.string   "bitpay_id"
    t.string   "url"
    t.string   "pos_data",        limit: 100
    t.string   "state",           limit: 10,                           default: "new", null: false
    t.decimal  "price",                       precision: 10, scale: 0,                 null: false
    t.string   "currency",        limit: 3,                                            null: false
    t.string   "order_id",        limit: 100
    t.string   "item_desc",       limit: 100
    t.string   "item_code",       limit: 100
    t.boolean  "physical",                                             default: false, null: false
    t.string   "buyer_name",      limit: 100
    t.string   "buyer_address_1", limit: 100
    t.string   "buyer_address_2", limit: 100
    t.string   "buyer_city",      limit: 100
    t.string   "buyer_state",     limit: 100
    t.string   "buyer_zip",       limit: 100
    t.string   "buyer_country",   limit: 100
    t.string   "buyer_email",     limit: 100
    t.string   "buyer_phone",     limit: 100
    t.decimal  "btc_price",                   precision: 10, scale: 0
    t.datetime "invoice_time"
    t.datetime "expiration_time"
    t.datetime "current_time"
  end

  create_table "bit_pay_rates", force: true do |t|
    t.string  "name"
    t.string  "code", limit: 3
    t.decimal "rate",           precision: 10, scale: 0
  end

  create_table "cart_items", force: true do |t|
    t.integer "cart_id",                  null: false
    t.float   "proportion",   limit: 24
    t.integer "item_id",                  null: false
    t.string  "item_type",                null: false
    t.text    "reason"
    t.string  "short_reason", limit: 140
    t.text    "message"
  end

  add_index "cart_items", ["cart_id", "item_type", "item_id"], name: "index_cart_items_on_cart_id_and_item_type_and_item_id", unique: true, using: :btree
  add_index "cart_items", ["item_type", "item_id"], name: "index_cart_items_on_item_type_and_item_id", using: :btree

  create_table "carts", force: true do |t|
    t.integer  "owner_id"
    t.string   "state"
    t.integer  "cart_items_count", default: 0
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type"
    t.string   "name"
    t.text     "reason"
    t.text     "short_reason"
  end

  add_index "carts", ["owner_id", "owner_type", "name"], name: "index_carts_on_owner_id_and_owner_type_and_name", using: :btree
  add_index "carts", ["state"], name: "index_carts_on_state", using: :btree

  create_table "committees", force: true do |t|
    t.integer  "legal_committee_id"
    t.string   "legal_committee_type"
    t.string   "jurisdiction",                               null: false
    t.string   "acronym"
    t.string   "short_name"
    t.string   "full_name",                                  null: false
    t.string   "type"
    t.string   "legal_id"
    t.string   "corporation_acronym"
    t.string   "corporation_full_name"
    t.string   "corporation_type"
    t.string   "corporation_ein"
    t.string   "contact_name"
    t.string   "contact_title"
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.string   "party"
    t.string   "address"
    t.string   "paypal_email"
    t.string   "status"
    t.text     "notes"
    t.boolean  "foreign_contributions_okay", default: false
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "death_master_files", force: true do |t|
    t.string   "social_security_number"
    t.string   "last_name"
    t.string   "name_suffix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "verify_proof_code"
    t.date     "date_of_death"
    t.date     "date_of_birth"
    t.string   "state_of_residence"
    t.string   "last_known_zip_residence"
    t.string   "last_known_zip_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "as_of"
  end

  add_index "death_master_files", ["as_of"], name: "idx_as_of", using: :btree
  add_index "death_master_files", ["social_security_number"], name: "idx_ssn", unique: true, using: :btree

  create_table "emails", force: true do |t|
    t.string   "from_address",                        null: false
    t.string   "reply_to_address"
    t.string   "subject"
    t.text     "to_address"
    t.text     "cc_address"
    t.text     "bcc_address"
    t.text     "content",          limit: 2147483647
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["created_at"], name: "index_emails_on_created_at", using: :btree
  add_index "emails", ["from_address", "subject"], name: "index_emails_on_from_address_and_subject", using: :btree
  add_index "emails", ["sent_at"], name: "index_emails_on_sent_at", using: :btree

  create_table "fec_candidates", force: true do |t|
    t.string   "fec_id",                       limit: 9,              null: false
    t.string   "name",                         limit: 38
    t.string   "party",                        limit: 3
    t.string   "party_2",                      limit: 3
    t.string   "incumbent_challenger",         limit: 1
    t.string   "status",                       limit: 1
    t.string   "street_1",                     limit: 34
    t.string   "street_2",                     limit: 34
    t.string   "city",                         limit: 18
    t.string   "state",                        limit: 2
    t.string   "zip",                          limit: 5
    t.string   "principal_campaign_committee", limit: 9
    t.string   "year",                         limit: 2
    t.string   "district",                     limit: 2
    t.integer  "last_update_year"
    t.integer  "lock_version",                            default: 0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "fec_candidates", ["district"], name: "index_fec_candidates_on_district", using: :btree
  add_index "fec_candidates", ["fec_id"], name: "index_fec_candidates_on_fec_id", unique: true, using: :btree
  add_index "fec_candidates", ["incumbent_challenger"], name: "index_fec_candidates_on_incumbent_challenger", using: :btree
  add_index "fec_candidates", ["name"], name: "index_fec_candidates_on_name", using: :btree
  add_index "fec_candidates", ["party"], name: "index_fec_candidates_on_party", using: :btree
  add_index "fec_candidates", ["party_2"], name: "index_fec_candidates_on_party_2", using: :btree
  add_index "fec_candidates", ["principal_campaign_committee"], name: "index_fec_candidates_on_principal_campaign_committee", using: :btree
  add_index "fec_candidates", ["state", "city"], name: "index_fec_candidates_on_state_and_city", using: :btree
  add_index "fec_candidates", ["status"], name: "index_fec_candidates_on_status", using: :btree
  add_index "fec_candidates", ["updated_at"], name: "index_fec_candidates_on_updated_at", using: :btree
  add_index "fec_candidates", ["year"], name: "index_fec_candidates_on_year", using: :btree

  create_table "fec_committees", force: true do |t|
    t.string   "fec_id",                      limit: 9,              null: false
    t.string   "name",                        limit: 90,             null: false
    t.string   "treasurer_name",              limit: 38
    t.string   "street_1",                    limit: 34
    t.string   "street_2",                    limit: 34
    t.string   "city",                        limit: 18
    t.string   "state",                       limit: 2
    t.string   "zip",                         limit: 5
    t.string   "designation",                 limit: 1
    t.string   "type",                        limit: 1
    t.string   "party",                       limit: 3
    t.string   "filing_frequency",            limit: 1
    t.string   "interest_group_category",     limit: 1
    t.string   "connected_organization_name", limit: 38
    t.string   "candidate_id",                limit: 9
    t.integer  "last_update_year"
    t.integer  "lock_version",                           default: 0
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "fec_committees", ["candidate_id"], name: "index_fec_committees_on_candidate_id", using: :btree
  add_index "fec_committees", ["connected_organization_name"], name: "index_fec_committees_on_connected_organization_name", using: :btree
  add_index "fec_committees", ["designation"], name: "index_fec_committees_on_designation", using: :btree
  add_index "fec_committees", ["fec_id"], name: "index_fec_committees_on_fec_id", unique: true, using: :btree
  add_index "fec_committees", ["interest_group_category"], name: "index_fec_committees_on_interest_group_category", using: :btree
  add_index "fec_committees", ["name"], name: "index_fec_committees_on_name", using: :btree
  add_index "fec_committees", ["party"], name: "index_fec_committees_on_party", using: :btree
  add_index "fec_committees", ["state", "city"], name: "index_fec_committees_on_state_and_city", using: :btree
  add_index "fec_committees", ["treasurer_name"], name: "index_fec_committees_on_treasurer_name", using: :btree
  add_index "fec_committees", ["updated_at"], name: "index_fec_committees_on_updated_at", using: :btree

  create_table "fec_filing_f1", force: true do |t|
    t.integer  "fec_record_number",                                        null: false, unsigned: true
    t.integer  "row_number",                                               null: false, unsigned: true
    t.integer  "lock_version",                               default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                      limit: 8
    t.string   "filer_committee_id_number",      limit: 9
    t.string   "change_of_committee_name",       limit: 1
    t.string   "committee_name",                 limit: 200
    t.string   "change_of_address",              limit: 1
    t.string   "street_1",                       limit: 34
    t.string   "street_2",                       limit: 34
    t.string   "city",                           limit: 30
    t.string   "state",                          limit: 2
    t.string   "zip_code",                       limit: 9
    t.string   "change_of_committee_email",      limit: 1
    t.string   "committee_email",                limit: 90
    t.string   "change_of_committee_url",        limit: 1
    t.string   "committee_url",                  limit: 90
    t.date     "effective_date"
    t.string   "signature_last_name",            limit: 30
    t.string   "signature_first_name",           limit: 20
    t.string   "signature_middle_name",          limit: 20
    t.string   "signature_prefix",               limit: 10
    t.string   "signature_suffix",               limit: 10
    t.date     "date_signed"
    t.string   "committee_type",                 limit: 1
    t.string   "candidate_id_number",            limit: 9
    t.string   "candidate_last_name",            limit: 30
    t.string   "candidate_first_name",           limit: 20
    t.string   "candidate_middle_name",          limit: 20
    t.string   "candidate_prefix",               limit: 10
    t.string   "candidate_suffix",               limit: 10
    t.string   "candidate_office",               limit: 1
    t.string   "candidate_state",                limit: 2
    t.string   "candidate_district",             limit: 2
    t.string   "party_code",                     limit: 3
    t.string   "party_type",                     limit: 3
    t.string   "organization_type",              limit: 1
    t.string   "lobbyist_registrant_pac",        limit: 1
    t.string   "lobbyist_registrant_pac_2",      limit: 1
    t.string   "leadership_pac",                 limit: 1
    t.string   "affiliated_committee_id_number", limit: 9
    t.string   "affiliated_committee_name",      limit: 200
    t.string   "affiliated_candidate_id_number", limit: 9
    t.string   "affiliated_last_name",           limit: 30
    t.string   "affiliated_first_name",          limit: 20
    t.string   "affiliated_middle_name",         limit: 20
    t.string   "affiliated_prefix",              limit: 10
    t.string   "affiliated_suffix",              limit: 10
    t.string   "affiliated_street_1",            limit: 34
    t.string   "affiliated_street_2",            limit: 34
    t.string   "affiliated_city",                limit: 30
    t.string   "affiliated_state",               limit: 2
    t.string   "affiliated_zip_code",            limit: 9
    t.string   "affiliated_relationship_code",   limit: 38
    t.string   "custodian_last_name",            limit: 30
    t.string   "custodian_first_name",           limit: 20
    t.string   "custodian_middle_name",          limit: 20
    t.string   "custodian_prefix",               limit: 10
    t.string   "custodian_suffix",               limit: 10
    t.string   "custodian_street_1",             limit: 34
    t.string   "custodian_street_2",             limit: 34
    t.string   "custodian_city",                 limit: 30
    t.string   "custodian_state",                limit: 2
    t.string   "custodian_zip_code",             limit: 9
    t.string   "custodian_title",                limit: 20
    t.string   "custodian_telephone",            limit: 10
    t.string   "treasurer_last_name",            limit: 30
    t.string   "treasurer_first_name",           limit: 20
    t.string   "treasurer_middle_name",          limit: 20
    t.string   "treasurer_prefix",               limit: 10
    t.string   "treasurer_suffix",               limit: 10
    t.string   "treasurer_street_1",             limit: 34
    t.string   "treasurer_street_2",             limit: 34
    t.string   "treasurer_city",                 limit: 30
    t.string   "treasurer_state",                limit: 2
    t.string   "treasurer_zip_code",             limit: 9
    t.string   "treasurer_title",                limit: 20
    t.string   "treasurer_telephone",            limit: 10
    t.string   "agent_last_name",                limit: 30
    t.string   "agent_first_name",               limit: 20
    t.string   "agent_middle_name",              limit: 20
    t.string   "agent_prefix",                   limit: 10
    t.string   "agent_suffix",                   limit: 10
    t.string   "agent_street_1",                 limit: 34
    t.string   "agent_street_2",                 limit: 34
    t.string   "agent_city",                     limit: 30
    t.string   "agent_state",                    limit: 2
    t.string   "agent_zip_code",                 limit: 9
    t.string   "agent_title",                    limit: 20
    t.string   "agent_telephone",                limit: 10
    t.string   "bank_name",                      limit: 200
    t.string   "bank_street_1",                  limit: 34
    t.string   "bank_street_2",                  limit: 34
    t.string   "bank_city",                      limit: 30
    t.string   "bank_state",                     limit: 2
    t.string   "bank_zip_code",                  limit: 9
    t.string   "bank2_name",                     limit: 200
    t.string   "bank2_street_1",                 limit: 34
    t.string   "bank2_street_2",                 limit: 34
    t.string   "bank2_city",                     limit: 30
    t.string   "bank2_state",                    limit: 2
    t.string   "bank2_zip_code",                 limit: 9
    t.string   "candidate_name",                 limit: 200
    t.string   "custodian_name",                 limit: 200
    t.string   "treasurer_name",                 limit: 200
    t.string   "agent_name",                     limit: 200
    t.string   "signature_name",                 limit: 200
    t.string   "committee_fax_number",           limit: 10
    t.string   "fec_record_type",                limit: 1,   default: "C"
  end

  add_index "fec_filing_f1", ["affiliated_candidate_id_number"], name: "index_fec_filing_f1_on_affiliated_candidate_id_number", using: :btree
  add_index "fec_filing_f1", ["affiliated_committee_id_number"], name: "index_fec_filing_f1_on_affiliated_committee_id_number", using: :btree
  add_index "fec_filing_f1", ["affiliated_committee_name"], name: "index_fec_filing_f1_on_affiliated_committee_name", using: :btree
  add_index "fec_filing_f1", ["agent_name"], name: "index_fec_filing_f1_on_agent_name", using: :btree
  add_index "fec_filing_f1", ["bank2_name"], name: "index_fec_filing_f1_on_bank2_name", using: :btree
  add_index "fec_filing_f1", ["bank_name"], name: "index_fec_filing_f1_on_bank_name", using: :btree
  add_index "fec_filing_f1", ["candidate_id_number"], name: "index_fec_filing_f1_on_candidate_id_number", using: :btree
  add_index "fec_filing_f1", ["candidate_name"], name: "index_fec_filing_f1_on_candidate_name", using: :btree
  add_index "fec_filing_f1", ["committee_name"], name: "index_fec_filing_f1_on_committee_name", using: :btree
  add_index "fec_filing_f1", ["custodian_name"], name: "index_fec_filing_f1_on_custodian_name", using: :btree
  add_index "fec_filing_f1", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f1", ["filer_committee_id_number"], name: "index_fec_filing_f1_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f1", ["signature_name"], name: "index_fec_filing_f1_on_signature_name", using: :btree
  add_index "fec_filing_f1", ["treasurer_name"], name: "index_fec_filing_f1_on_treasurer_name", using: :btree

  create_table "fec_filing_f13", force: true do |t|
    t.integer  "fec_record_number",                                                            null: false, unsigned: true
    t.integer  "row_number",                                                                   null: false, unsigned: true
    t.integer  "lock_version",                                                   default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "committee_name",            limit: 200
    t.string   "change_of_address",         limit: 1
    t.string   "street_1",                  limit: 34
    t.string   "street_2",                  limit: 34
    t.string   "city",                      limit: 30
    t.string   "state",                     limit: 2
    t.string   "zip_code",                  limit: 9
    t.string   "report_code",               limit: 3
    t.date     "amendment_date"
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.decimal  "total_donations_accepted",              precision: 12, scale: 2
    t.decimal  "total_donations_refunded",              precision: 12, scale: 2
    t.decimal  "net_donations",                         precision: 12, scale: 2
    t.string   "designated_last_name",      limit: 30
    t.string   "designated_first_name",     limit: 20
    t.string   "designated_middle_name",    limit: 20
    t.string   "designated_prefix",         limit: 10
    t.string   "designated_suffix",         limit: 10
    t.date     "date_signed"
    t.string   "fec_record_type",           limit: 1,                            default: "C"
  end

  add_index "fec_filing_f13", ["committee_name"], name: "index_fec_filing_f13_on_committee_name", using: :btree
  add_index "fec_filing_f13", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f13", ["filer_committee_id_number"], name: "index_fec_filing_f13_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f132", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id_number",         limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip",               limit: 9
    t.date     "donation_date"
    t.decimal  "donation_amount",                           precision: 12, scale: 2
    t.decimal  "donation_aggregate_amount",                 precision: 12, scale: 2
    t.string   "memo_code",                     limit: 1
    t.string   "memo_text_description",         limit: 100
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f132", ["contributor_organization_name"], name: "index_fec_filing_f132_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f132", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f132", ["filer_committee_id_number"], name: "index_fec_filing_f132_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f133", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id_number",         limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip",               limit: 9
    t.date     "refund_date"
    t.decimal  "refund_amount",                             precision: 12, scale: 2
    t.string   "memo_code",                     limit: 1
    t.string   "memo_text_description",         limit: 100
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f133", ["contributor_organization_name"], name: "index_fec_filing_f133_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f133", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f133", ["filer_committee_id_number"], name: "index_fec_filing_f133_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f1m", force: true do |t|
    t.integer  "fec_record_number",                                            null: false, unsigned: true
    t.integer  "row_number",                                                   null: false, unsigned: true
    t.integer  "lock_version",                                   default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                          limit: 8
    t.string   "filer_committee_id_number",          limit: 9
    t.string   "committee_name",                     limit: 200
    t.string   "street_1",                           limit: 34
    t.string   "street_2",                           limit: 34
    t.string   "city",                               limit: 30
    t.string   "state",                              limit: 2
    t.string   "zip_code",                           limit: 9
    t.string   "committee_type",                     limit: 1
    t.date     "affiliated_date_f1_filed"
    t.string   "affiliated_committee_id_number",     limit: 9
    t.string   "affiliated_committee_name",          limit: 200
    t.string   "first_candidate_id_number",          limit: 9
    t.string   "first_candidate_last_name",          limit: 30
    t.string   "first_candidate_first_name",         limit: 20
    t.string   "first_candidate_middle_name",        limit: 20
    t.string   "first_candidate_prefix",             limit: 10
    t.string   "first_candidate_suffix",             limit: 10
    t.string   "first_candidate_office",             limit: 1
    t.string   "first_candidate_state",              limit: 2
    t.string   "first_candidate_district",           limit: 2
    t.date     "first_candidate_contribution_date"
    t.string   "second_candidate_id_number",         limit: 9
    t.string   "second_candidate_last_name",         limit: 30
    t.string   "second_candidate_second_name",       limit: 200
    t.string   "second_candidate_middle_name",       limit: 20
    t.string   "second_candidate_prefix",            limit: 10
    t.string   "second_candidate_suffix",            limit: 10
    t.string   "second_candidate_office",            limit: 1
    t.string   "second_candidate_state",             limit: 2
    t.string   "second_candidate_district",          limit: 2
    t.date     "second_candidate_contribution_date"
    t.string   "third_candidate_id_number",          limit: 9
    t.string   "third_candidate_last_name",          limit: 30
    t.string   "third_candidate_third_name",         limit: 200
    t.string   "third_candidate_middle_name",        limit: 20
    t.string   "third_candidate_prefix",             limit: 10
    t.string   "third_candidate_suffix",             limit: 10
    t.string   "third_candidate_office",             limit: 1
    t.string   "third_candidate_state",              limit: 2
    t.string   "third_candidate_district",           limit: 2
    t.date     "third_candidate_contribution_date"
    t.string   "fourth_candidate_id_number",         limit: 9
    t.string   "fourth_candidate_last_name",         limit: 30
    t.string   "fourth_candidate_fourth_name",       limit: 200
    t.string   "fourth_candidate_middle_name",       limit: 20
    t.string   "fourth_candidate_prefix",            limit: 10
    t.string   "fourth_candidate_suffix",            limit: 10
    t.string   "fourth_candidate_office",            limit: 1
    t.string   "fourth_candidate_state",             limit: 2
    t.string   "fourth_candidate_district",          limit: 2
    t.date     "fourth_candidate_contribution_date"
    t.string   "fifth_candidate_id_number",          limit: 9
    t.string   "fifth_candidate_last_name",          limit: 30
    t.string   "fifth_candidate_fifth_name",         limit: 200
    t.string   "fifth_candidate_middle_name",        limit: 20
    t.string   "fifth_candidate_prefix",             limit: 10
    t.string   "fifth_candidate_suffix",             limit: 10
    t.string   "fifth_candidate_office",             limit: 1
    t.string   "fifth_candidate_state",              limit: 2
    t.string   "fifth_candidate_district",           limit: 2
    t.date     "fifth_candidate_contribution_date"
    t.date     "fifty_first_contributor_date"
    t.date     "original_registration_date"
    t.date     "requirements_met_date"
    t.string   "treasurer_last_name",                limit: 30
    t.string   "treasurer_first_name",               limit: 20
    t.string   "treasurer_middle_name",              limit: 20
    t.string   "treasurer_prefix",                   limit: 10
    t.string   "treasurer_suffix",                   limit: 10
    t.date     "date_signed"
    t.string   "first_candidate_name",               limit: 200
    t.string   "second_candidate_name",              limit: 200
    t.string   "third_candidate_name",               limit: 200
    t.string   "fourth_candidate_name",              limit: 200
    t.string   "fifth_candidate_name",               limit: 200
    t.string   "treasurer_name",                     limit: 200
    t.string   "fec_record_type",                    limit: 1,   default: "C"
  end

  add_index "fec_filing_f1m", ["affiliated_committee_id_number"], name: "index_fec_filing_f1m_on_affiliated_committee_id_number", using: :btree
  add_index "fec_filing_f1m", ["affiliated_committee_name"], name: "index_fec_filing_f1m_on_affiliated_committee_name", using: :btree
  add_index "fec_filing_f1m", ["committee_name"], name: "index_fec_filing_f1m_on_committee_name", using: :btree
  add_index "fec_filing_f1m", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f1m", ["fifth_candidate_fifth_name"], name: "index_fec_filing_f1m_on_fifth_candidate_fifth_name", using: :btree
  add_index "fec_filing_f1m", ["fifth_candidate_id_number"], name: "index_fec_filing_f1m_on_fifth_candidate_id_number", using: :btree
  add_index "fec_filing_f1m", ["fifth_candidate_name"], name: "index_fec_filing_f1m_on_fifth_candidate_name", using: :btree
  add_index "fec_filing_f1m", ["filer_committee_id_number"], name: "index_fec_filing_f1m_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f1m", ["first_candidate_id_number"], name: "index_fec_filing_f1m_on_first_candidate_id_number", using: :btree
  add_index "fec_filing_f1m", ["first_candidate_name"], name: "index_fec_filing_f1m_on_first_candidate_name", using: :btree
  add_index "fec_filing_f1m", ["fourth_candidate_fourth_name"], name: "index_fec_filing_f1m_on_fourth_candidate_fourth_name", using: :btree
  add_index "fec_filing_f1m", ["fourth_candidate_id_number"], name: "index_fec_filing_f1m_on_fourth_candidate_id_number", using: :btree
  add_index "fec_filing_f1m", ["fourth_candidate_name"], name: "index_fec_filing_f1m_on_fourth_candidate_name", using: :btree
  add_index "fec_filing_f1m", ["second_candidate_id_number"], name: "index_fec_filing_f1m_on_second_candidate_id_number", using: :btree
  add_index "fec_filing_f1m", ["second_candidate_name"], name: "index_fec_filing_f1m_on_second_candidate_name", using: :btree
  add_index "fec_filing_f1m", ["second_candidate_second_name"], name: "index_fec_filing_f1m_on_second_candidate_second_name", using: :btree
  add_index "fec_filing_f1m", ["third_candidate_id_number"], name: "index_fec_filing_f1m_on_third_candidate_id_number", using: :btree
  add_index "fec_filing_f1m", ["third_candidate_name"], name: "index_fec_filing_f1m_on_third_candidate_name", using: :btree
  add_index "fec_filing_f1m", ["third_candidate_third_name"], name: "index_fec_filing_f1m_on_third_candidate_third_name", using: :btree
  add_index "fec_filing_f1m", ["treasurer_name"], name: "index_fec_filing_f1m_on_treasurer_name", using: :btree

  create_table "fec_filing_f1s", force: true do |t|
    t.integer  "fec_record_number",                                                    null: false, unsigned: true
    t.integer  "row_number",                                                           null: false, unsigned: true
    t.integer  "lock_version",                                           default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                  limit: 8
    t.string   "filer_committee_id_number",                  limit: 9
    t.string   "joint_fund_participant_committee_name",      limit: 200
    t.string   "joint_fund_participant_committee_id_number", limit: 9
    t.string   "affiliated_committee_id_number",             limit: 9
    t.string   "affiliated_committee_name",                  limit: 200
    t.string   "affiliated_candidate_id_number",             limit: 9
    t.string   "affiliated_last_name",                       limit: 30
    t.string   "affiliated_first_name",                      limit: 20
    t.string   "affiliated_middle_name",                     limit: 20
    t.string   "affiliated_prefix",                          limit: 10
    t.string   "affiliated_suffix",                          limit: 10
    t.string   "affiliated_street_1",                        limit: 34
    t.string   "affiliated_street_2",                        limit: 34
    t.string   "affiliated_city",                            limit: 30
    t.string   "affiliated_state",                           limit: 2
    t.string   "affiliated_zip_code",                        limit: 9
    t.string   "affiliated_relationship_code",               limit: 38
    t.string   "agent_last_name",                            limit: 30
    t.string   "agent_first_name",                           limit: 20
    t.string   "agent_middle_name",                          limit: 20
    t.string   "agent_prefix",                               limit: 10
    t.string   "agent_suffix",                               limit: 10
    t.string   "agent_street_1",                             limit: 34
    t.string   "agent_street_2",                             limit: 34
    t.string   "agent_city",                                 limit: 30
    t.string   "agent_state",                                limit: 2
    t.string   "agent_zip_code",                             limit: 9
    t.string   "agent_title",                                limit: 20
    t.string   "agent_telephone",                            limit: 10
    t.string   "bank_name",                                  limit: 200
    t.string   "bank_street_1",                              limit: 34
    t.string   "bank_street_2",                              limit: 34
    t.string   "bank_city",                                  limit: 30
    t.string   "bank_state",                                 limit: 2
    t.string   "bank_zip_code",                              limit: 9
    t.string   "fec_record_type",                            limit: 1,   default: "C"
  end

  add_index "fec_filing_f1s", ["affiliated_candidate_id_number"], name: "index_fec_filing_f1s_on_affiliated_candidate_id_number", using: :btree
  add_index "fec_filing_f1s", ["affiliated_committee_id_number"], name: "index_fec_filing_f1s_on_affiliated_committee_id_number", using: :btree
  add_index "fec_filing_f1s", ["affiliated_committee_name"], name: "index_fec_filing_f1s_on_affiliated_committee_name", using: :btree
  add_index "fec_filing_f1s", ["bank_name"], name: "index_fec_filing_f1s_on_bank_name", using: :btree
  add_index "fec_filing_f1s", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f1s", ["filer_committee_id_number"], name: "index_fec_filing_f1s_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f1s", ["joint_fund_participant_committee_id_number"], name: "index_fec_filing_f1s_on_jfp_cid", using: :btree
  add_index "fec_filing_f1s", ["joint_fund_participant_committee_name"], name: "index_fec_filing_f1s_on_jfp_cn", using: :btree

  create_table "fec_filing_f2", force: true do |t|
    t.integer  "fec_record_number",                                                                  null: false, unsigned: true
    t.integer  "row_number",                                                                         null: false, unsigned: true
    t.integer  "lock_version",                                                         default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                       limit: 8
    t.string   "candidate_id_number",             limit: 9
    t.string   "candidate_last_name",             limit: 30
    t.string   "candidate_first_name",            limit: 20
    t.string   "candidate_middle_name",           limit: 20
    t.string   "candidate_prefix",                limit: 10
    t.string   "candidate_suffix",                limit: 10
    t.string   "change_of_address",               limit: 1
    t.string   "candidate_street_1",              limit: 34
    t.string   "candidate_street_2",              limit: 34
    t.string   "candidate_city",                  limit: 30
    t.string   "candidate_state",                 limit: 2
    t.string   "candidate_zip_code",              limit: 9
    t.string   "candidate_party_code",            limit: 3
    t.string   "candidate_office",                limit: 1
    t.string   "candidate_district",              limit: 2
    t.integer  "election_year",                                                                                   unsigned: true
    t.string   "committee_id_number",             limit: 9
    t.string   "committee_name",                  limit: 200
    t.string   "committee_street_1",              limit: 34
    t.string   "committee_street_2",              limit: 34
    t.string   "committee_city",                  limit: 30
    t.string   "committee_state",                 limit: 2
    t.string   "committee_zip_code",              limit: 9
    t.string   "authorized_committee_id_number",  limit: 9
    t.string   "authorized_committee_name",       limit: 200
    t.string   "authorized_committee_street_1",   limit: 34
    t.string   "authorized_committee_street_2",   limit: 34
    t.string   "authorized_committee_city",       limit: 30
    t.string   "authorized_committee_state",      limit: 2
    t.string   "authorized_committee_zip_code",   limit: 9
    t.string   "candidate_signature_last_name",   limit: 30
    t.string   "candidate_signature_first_name",  limit: 20
    t.string   "candidate_signature_middle_name", limit: 20
    t.string   "candidate_signature_prefix",      limit: 10
    t.string   "candidate_signature_suffix",      limit: 10
    t.date     "date_signed"
    t.decimal  "primary_personal_funds_declared",             precision: 12, scale: 2
    t.decimal  "general_personal_funds_declared",             precision: 12, scale: 2
    t.string   "candidate_name",                  limit: 200
    t.string   "candidate_signature_name",        limit: 200
    t.string   "fec_record_type",                 limit: 1,                            default: "C"
  end

  add_index "fec_filing_f2", ["authorized_committee_id_number"], name: "index_fec_filing_f2_on_authorized_committee_id_number", using: :btree
  add_index "fec_filing_f2", ["authorized_committee_name"], name: "index_fec_filing_f2_on_authorized_committee_name", using: :btree
  add_index "fec_filing_f2", ["candidate_id_number"], name: "index_fec_filing_f2_on_candidate_id_number", using: :btree
  add_index "fec_filing_f2", ["candidate_name"], name: "index_fec_filing_f2_on_candidate_name", using: :btree
  add_index "fec_filing_f2", ["candidate_signature_name"], name: "index_fec_filing_f2_on_candidate_signature_name", using: :btree
  add_index "fec_filing_f2", ["committee_id_number"], name: "index_fec_filing_f2_on_committee_id_number", using: :btree
  add_index "fec_filing_f2", ["committee_name"], name: "index_fec_filing_f2_on_committee_name", using: :btree
  add_index "fec_filing_f2", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree

  create_table "fec_filing_f24", force: true do |t|
    t.integer  "fec_record_number",                                   null: false, unsigned: true
    t.integer  "row_number",                                          null: false, unsigned: true
    t.integer  "lock_version",                          default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "report_type",               limit: 3
    t.date     "original_amendment_date"
    t.string   "committee_name",            limit: 200
    t.string   "street_1",                  limit: 34
    t.string   "street_2",                  limit: 34
    t.string   "city",                      limit: 30
    t.string   "state",                     limit: 2
    t.string   "zip_code",                  limit: 9
    t.string   "treasurer_last_name",       limit: 30
    t.string   "treasurer_first_name",      limit: 20
    t.string   "treasurer_middle_name",     limit: 20
    t.string   "treasurer_prefix",          limit: 10
    t.string   "treasurer_suffix",          limit: 10
    t.date     "date_signed"
    t.string   "fec_record_type",           limit: 1,   default: "C"
  end

  add_index "fec_filing_f24", ["committee_name"], name: "index_fec_filing_f24_on_committee_name", using: :btree
  add_index "fec_filing_f24", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f24", ["filer_committee_id_number"], name: "index_fec_filing_f24_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f3", force: true do |t|
    t.integer  "fec_record_number",                                                                                    null: false, unsigned: true
    t.integer  "row_number",                                                                                           null: false, unsigned: true
    t.integer  "lock_version",                                                                           default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                         limit: 8
    t.string   "filer_committee_id_number",                         limit: 9
    t.string   "committee_name",                                    limit: 200
    t.string   "change_of_address",                                 limit: 1
    t.string   "street_1",                                          limit: 34
    t.string   "street_2",                                          limit: 34
    t.string   "city",                                              limit: 30
    t.string   "state",                                             limit: 2
    t.string   "zip_code",                                          limit: 9
    t.string   "election_state",                                    limit: 2
    t.string   "election_district",                                 limit: 2
    t.string   "report_code",                                       limit: 3
    t.string   "election_code",                                     limit: 5
    t.date     "election_date"
    t.string   "state_of_election",                                 limit: 2
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.string   "treasurer_last_name",                               limit: 30
    t.string   "treasurer_first_name",                              limit: 20
    t.string   "treasurer_middle_name",                             limit: 20
    t.string   "treasurer_prefix",                                  limit: 10
    t.string   "treasurer_suffix",                                  limit: 10
    t.date     "date_signed"
    t.decimal  "col_a_total_contributions_no_loans",                            precision: 12, scale: 2
    t.decimal  "col_a_total_contributions_refunds",                             precision: 12, scale: 2
    t.decimal  "col_a_net_contributions",                                       precision: 12, scale: 2
    t.decimal  "col_a_total_operating_expenditures",                            precision: 12, scale: 2
    t.decimal  "col_a_total_offset_to_operating_expenditures",                  precision: 12, scale: 2
    t.decimal  "col_a_net_operating_expenditures",                              precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_close_of_period",                            precision: 12, scale: 2
    t.decimal  "col_a_debts_to",                                                precision: 12, scale: 2
    t.decimal  "col_a_debts_by",                                                precision: 12, scale: 2
    t.decimal  "col_a_individual_contributions_itemized",                       precision: 12, scale: 2
    t.decimal  "col_a_individual_contributions_unitemized",                     precision: 12, scale: 2
    t.decimal  "col_a_total_individual_contributions",                          precision: 12, scale: 2
    t.decimal  "col_a_political_party_contributions",                           precision: 12, scale: 2
    t.decimal  "col_a_pac_contributions",                                       precision: 12, scale: 2
    t.decimal  "col_a_candidate_contributions",                                 precision: 12, scale: 2
    t.decimal  "col_a_total_contributions",                                     precision: 12, scale: 2
    t.decimal  "col_a_transfers_from_authorized",                               precision: 12, scale: 2
    t.decimal  "col_a_candidate_loans",                                         precision: 12, scale: 2
    t.decimal  "col_a_other_loans",                                             precision: 12, scale: 2
    t.decimal  "col_a_total_loans",                                             precision: 12, scale: 2
    t.decimal  "col_a_offset_to_operating_expenditures",                        precision: 12, scale: 2
    t.decimal  "col_a_other_receipts",                                          precision: 12, scale: 2
    t.decimal  "col_a_total_receipts",                                          precision: 12, scale: 2
    t.decimal  "col_a_operating_expenditures",                                  precision: 12, scale: 2
    t.decimal  "col_a_transfers_to_authorized",                                 precision: 12, scale: 2
    t.decimal  "col_a_candidate_loan_repayments",                               precision: 12, scale: 2
    t.decimal  "col_a_other_loan_repayments",                                   precision: 12, scale: 2
    t.decimal  "col_a_total_loan_repayments",                                   precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_individuals",                                  precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_party_committees",                             precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_other_committees",                             precision: 12, scale: 2
    t.decimal  "col_a_total_refunds",                                           precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements",                                     precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements",                                     precision: 12, scale: 2
    t.decimal  "col_a_cash_beginning_reporting_period",                         precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements_period",                              precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_close",                                      precision: 12, scale: 2
    t.decimal  "col_b_total_contributions_no_loans",                            precision: 12, scale: 2
    t.decimal  "col_b_total_contributions_refunds",                             precision: 12, scale: 2
    t.decimal  "col_b_net_contributions",                                       precision: 12, scale: 2
    t.decimal  "col_b_total_operating_expenditures",                            precision: 12, scale: 2
    t.decimal  "col_b_total_offset_to_operating_expenditures",                  precision: 12, scale: 2
    t.decimal  "col_b_net_operating_expenditures",                              precision: 12, scale: 2
    t.decimal  "col_b_individual_contributions_itemized",                       precision: 12, scale: 2
    t.decimal  "col_b_individual_contributions_unitemized",                     precision: 12, scale: 2
    t.decimal  "col_b_total_individual_contributions",                          precision: 12, scale: 2
    t.decimal  "col_b_political_party_contributions",                           precision: 12, scale: 2
    t.decimal  "col_b_pac_contributions",                                       precision: 12, scale: 2
    t.decimal  "col_b_candidate_contributions",                                 precision: 12, scale: 2
    t.decimal  "col_b_total_contributions",                                     precision: 12, scale: 2
    t.decimal  "col_b_transfers_from_authorized",                               precision: 12, scale: 2
    t.decimal  "col_b_candidate_loans",                                         precision: 12, scale: 2
    t.decimal  "col_b_other_loans",                                             precision: 12, scale: 2
    t.decimal  "col_b_total_loans",                                             precision: 12, scale: 2
    t.decimal  "col_b_offset_to_operating_expenditures",                        precision: 12, scale: 2
    t.decimal  "col_b_other_receipts",                                          precision: 12, scale: 2
    t.decimal  "col_b_total_receipts",                                          precision: 12, scale: 2
    t.decimal  "col_b_operating_expenditures",                                  precision: 12, scale: 2
    t.decimal  "col_b_transfers_to_authorized",                                 precision: 12, scale: 2
    t.decimal  "col_b_candidate_loan_repayments",                               precision: 12, scale: 2
    t.decimal  "col_b_other_loan_repayments",                                   precision: 12, scale: 2
    t.decimal  "col_b_total_loan_repayments",                                   precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_individuals",                                  precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_party_committees",                             precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_other_committees",                             precision: 12, scale: 2
    t.decimal  "col_b_total_refunds",                                           precision: 12, scale: 2
    t.decimal  "col_b_other_disbursements",                                     precision: 12, scale: 2
    t.decimal  "col_b_total_disbursements",                                     precision: 12, scale: 2
    t.string   "candidate_id_number",                               limit: 9
    t.string   "candidate_last_name",                               limit: 30
    t.string   "candidate_first_name",                              limit: 20
    t.string   "candidate_middle_name",                             limit: 20
    t.string   "candidate_prefix",                                  limit: 10
    t.string   "candidate_suffix",                                  limit: 10
    t.string   "report_type",                                       limit: 3
    t.decimal  "col_b_gross_receipts_authorized_primary",                       precision: 12, scale: 2
    t.decimal  "col_b_aggregate_personal_funds_primary",                        precision: 12, scale: 2
    t.decimal  "col_b_gross_receipts_minus_personal_funds_primary",             precision: 12, scale: 2
    t.decimal  "col_b_gross_receipts_authorized_general",                       precision: 12, scale: 2
    t.decimal  "col_b_aggregate_personal_funds_general",                        precision: 12, scale: 2
    t.decimal  "col_b_gross_receipts_minus_personal_funds_general",             precision: 12, scale: 2
    t.string   "primary_election",                                  limit: 1
    t.string   "general_election",                                  limit: 1
    t.string   "special_election",                                  limit: 1
    t.string   "runoff_election",                                   limit: 1
    t.string   "treasurer_name",                                    limit: 200
    t.string   "candidate_name",                                    limit: 200
    t.string   "fec_record_type",                                   limit: 1,                            default: "C"
  end

  add_index "fec_filing_f3", ["candidate_id_number"], name: "index_fec_filing_f3_on_candidate_id_number", using: :btree
  add_index "fec_filing_f3", ["candidate_name"], name: "index_fec_filing_f3_on_candidate_name", using: :btree
  add_index "fec_filing_f3", ["committee_name"], name: "index_fec_filing_f3_on_committee_name", using: :btree
  add_index "fec_filing_f3", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3", ["filer_committee_id_number"], name: "index_fec_filing_f3_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f3", ["treasurer_name"], name: "index_fec_filing_f3_on_treasurer_name", using: :btree

  create_table "fec_filing_f3l", force: true do |t|
    t.integer  "fec_record_number",                                                                          null: false, unsigned: true
    t.integer  "row_number",                                                                                 null: false, unsigned: true
    t.integer  "lock_version",                                                                 default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                               limit: 8
    t.string   "filer_committee_id_number",               limit: 9
    t.string   "committee_name",                          limit: 200
    t.string   "change_of_address",                       limit: 1
    t.string   "street_1",                                limit: 34
    t.string   "street_2",                                limit: 34
    t.string   "city",                                    limit: 30
    t.string   "state",                                   limit: 2
    t.string   "zip_code",                                limit: 9
    t.string   "election_state",                          limit: 2
    t.string   "election_district",                       limit: 2
    t.string   "report_code",                             limit: 3
    t.date     "election_date"
    t.string   "semi_annual_period",                      limit: 1
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.string   "semi_annual_period_jan_june",             limit: 1
    t.string   "semi_annual_period_jul_dec",              limit: 1
    t.decimal  "quarterly_monthly_bundled_contributions",             precision: 12, scale: 2
    t.decimal  "semi_annual_bundled_contributions",                   precision: 12, scale: 2
    t.string   "treasurer_last_name",                     limit: 30
    t.string   "treasurer_first_name",                    limit: 20
    t.string   "treasurer_middle_name",                   limit: 20
    t.string   "treasurer_prefix",                        limit: 10
    t.string   "treasurer_suffix",                        limit: 10
    t.date     "date_signed"
    t.string   "fec_record_type",                         limit: 1,                            default: "C"
  end

  add_index "fec_filing_f3l", ["committee_name"], name: "index_fec_filing_f3l_on_committee_name", using: :btree
  add_index "fec_filing_f3l", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3l", ["filer_committee_id_number"], name: "index_fec_filing_f3l_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f3p", force: true do |t|
    t.integer  "fec_record_number",                                                                                 null: false, unsigned: true
    t.integer  "row_number",                                                                                        null: false, unsigned: true
    t.integer  "lock_version",                                                                        default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                      limit: 8
    t.string   "filer_committee_id_number",                      limit: 9
    t.string   "committee_name",                                 limit: 200
    t.string   "change_of_address",                              limit: 1
    t.string   "street_1",                                       limit: 34
    t.string   "street_2",                                       limit: 34
    t.string   "city",                                           limit: 30
    t.string   "state",                                          limit: 2
    t.string   "zip_code",                                       limit: 9
    t.string   "activity_primary",                               limit: 1
    t.string   "activity_general",                               limit: 1
    t.string   "report_code",                                    limit: 3
    t.string   "election_code",                                  limit: 5
    t.date     "date_of_election"
    t.string   "state_of_election",                              limit: 2
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.string   "treasurer_last_name",                            limit: 30
    t.string   "treasurer_first_name",                           limit: 20
    t.string   "treasurer_middle_name",                          limit: 20
    t.string   "treasurer_prefix",                               limit: 10
    t.string   "treasurer_suffix",                               limit: 10
    t.date     "date_signed"
    t.decimal  "col_a_cash_on_hand_beginning_period",                        precision: 12, scale: 2
    t.decimal  "col_a_total_receipts",                                       precision: 12, scale: 2
    t.decimal  "col_a_subtotal",                                             precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements",                                  precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_close_of_period",                         precision: 12, scale: 2
    t.decimal  "col_a_debts_to",                                             precision: 12, scale: 2
    t.decimal  "col_a_debts_by",                                             precision: 12, scale: 2
    t.decimal  "col_a_expenditures_subject_to_limits",                       precision: 12, scale: 2
    t.decimal  "col_a_net_contributions",                                    precision: 12, scale: 2
    t.decimal  "col_a_net_operating_expenditures",                           precision: 12, scale: 2
    t.decimal  "col_a_federal_funds",                                        precision: 12, scale: 2
    t.decimal  "col_a_individuals_itemized",                                 precision: 12, scale: 2
    t.decimal  "col_a_individuals_unitemized",                               precision: 12, scale: 2
    t.decimal  "col_a_individual_contribution_total",                        precision: 12, scale: 2
    t.decimal  "col_a_political_party_committees_receipts",                  precision: 12, scale: 2
    t.decimal  "col_a_other_political_committees_pacs",                      precision: 12, scale: 2
    t.decimal  "col_a_the_candidate",                                        precision: 12, scale: 2
    t.decimal  "col_a_total_contributions",                                  precision: 12, scale: 2
    t.decimal  "col_a_transfers_from_aff_other_party_cmttees",               precision: 12, scale: 2
    t.decimal  "col_a_received_from_or_guaranteed_by_cand",                  precision: 12, scale: 2
    t.decimal  "col_a_other_loans",                                          precision: 12, scale: 2
    t.decimal  "col_a_total_loans",                                          precision: 12, scale: 2
    t.decimal  "col_a_operating",                                            precision: 12, scale: 2
    t.decimal  "col_a_fundraising",                                          precision: 12, scale: 2
    t.decimal  "col_a_legal_and_accounting",                                 precision: 12, scale: 2
    t.decimal  "col_a_total_offsets_to_expenditures",                        precision: 12, scale: 2
    t.decimal  "col_a_other_receipts",                                       precision: 12, scale: 2
    t.decimal  "col_a_operating_expenditures",                               precision: 12, scale: 2
    t.decimal  "col_a_transfers_to_other_authorized_committees",             precision: 12, scale: 2
    t.decimal  "col_a_fundraising_disbursements",                            precision: 12, scale: 2
    t.decimal  "col_a_exempt_legal_accounting_disbursement",                 precision: 12, scale: 2
    t.decimal  "col_a_made_or_guaranteed_by_candidate",                      precision: 12, scale: 2
    t.decimal  "col_a_other_repayments",                                     precision: 12, scale: 2
    t.decimal  "col_a_total_loan_repayments_made",                           precision: 12, scale: 2
    t.decimal  "col_a_individuals",                                          precision: 12, scale: 2
    t.decimal  "col_a_political_party_committees_refunds",                   precision: 12, scale: 2
    t.decimal  "col_a_other_political_committees",                           precision: 12, scale: 2
    t.decimal  "col_a_total_contributions_refunds",                          precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements",                                  precision: 12, scale: 2
    t.decimal  "col_a_items_on_hand_to_be_liquidated",                       precision: 12, scale: 2
    t.decimal  "col_a_alabama",                                              precision: 12, scale: 2
    t.decimal  "col_a_alaska",                                               precision: 12, scale: 2
    t.decimal  "col_a_arizona",                                              precision: 12, scale: 2
    t.decimal  "col_a_arkansas",                                             precision: 12, scale: 2
    t.decimal  "col_a_california",                                           precision: 12, scale: 2
    t.decimal  "col_a_colorado",                                             precision: 12, scale: 2
    t.decimal  "col_a_connecticut",                                          precision: 12, scale: 2
    t.decimal  "col_a_delaware",                                             precision: 12, scale: 2
    t.decimal  "col_a_dist_of_columbia",                                     precision: 12, scale: 2
    t.decimal  "col_a_florida",                                              precision: 12, scale: 2
    t.decimal  "col_a_georgia",                                              precision: 12, scale: 2
    t.decimal  "col_a_hawaii",                                               precision: 12, scale: 2
    t.decimal  "col_a_idaho",                                                precision: 12, scale: 2
    t.decimal  "col_a_illinois",                                             precision: 12, scale: 2
    t.decimal  "col_a_indiana",                                              precision: 12, scale: 2
    t.decimal  "col_a_iowa",                                                 precision: 12, scale: 2
    t.decimal  "col_a_kansas",                                               precision: 12, scale: 2
    t.decimal  "col_a_kentucky",                                             precision: 12, scale: 2
    t.decimal  "col_a_louisiana",                                            precision: 12, scale: 2
    t.decimal  "col_a_maine",                                                precision: 12, scale: 2
    t.decimal  "col_a_maryland",                                             precision: 12, scale: 2
    t.decimal  "col_a_massachusetts",                                        precision: 12, scale: 2
    t.decimal  "col_a_michigan",                                             precision: 12, scale: 2
    t.decimal  "col_a_minnesota",                                            precision: 12, scale: 2
    t.decimal  "col_a_mississippi",                                          precision: 12, scale: 2
    t.decimal  "col_a_missouri",                                             precision: 12, scale: 2
    t.decimal  "col_a_montana",                                              precision: 12, scale: 2
    t.decimal  "col_a_nebraska",                                             precision: 12, scale: 2
    t.decimal  "col_a_nevada",                                               precision: 12, scale: 2
    t.decimal  "col_a_new_hampshire",                                        precision: 12, scale: 2
    t.decimal  "col_a_new_jersey",                                           precision: 12, scale: 2
    t.decimal  "col_a_new_mexico",                                           precision: 12, scale: 2
    t.decimal  "col_a_new_york",                                             precision: 12, scale: 2
    t.decimal  "col_a_north_carolina",                                       precision: 12, scale: 2
    t.decimal  "col_a_north_dakota",                                         precision: 12, scale: 2
    t.decimal  "col_a_ohio",                                                 precision: 12, scale: 2
    t.decimal  "col_a_oklahoma",                                             precision: 12, scale: 2
    t.decimal  "col_a_oregon",                                               precision: 12, scale: 2
    t.decimal  "col_a_pennsylvania",                                         precision: 12, scale: 2
    t.decimal  "col_a_rhode_island",                                         precision: 12, scale: 2
    t.decimal  "col_a_south_carolina",                                       precision: 12, scale: 2
    t.decimal  "col_a_south_dakota",                                         precision: 12, scale: 2
    t.decimal  "col_a_tennessee",                                            precision: 12, scale: 2
    t.decimal  "col_a_texas",                                                precision: 12, scale: 2
    t.decimal  "col_a_utah",                                                 precision: 12, scale: 2
    t.decimal  "col_a_vermont",                                              precision: 12, scale: 2
    t.decimal  "col_a_virginia",                                             precision: 12, scale: 2
    t.decimal  "col_a_washington",                                           precision: 12, scale: 2
    t.decimal  "col_a_west_virginia",                                        precision: 12, scale: 2
    t.decimal  "col_a_wisconsin",                                            precision: 12, scale: 2
    t.decimal  "col_a_wyoming",                                              precision: 12, scale: 2
    t.decimal  "col_a_puerto_rico",                                          precision: 12, scale: 2
    t.decimal  "col_a_guam",                                                 precision: 12, scale: 2
    t.decimal  "col_a_virgin_islands",                                       precision: 12, scale: 2
    t.decimal  "col_a_totals",                                               precision: 12, scale: 2
    t.decimal  "col_b_federal_funds",                                        precision: 12, scale: 2
    t.decimal  "col_b_individuals_itemized",                                 precision: 12, scale: 2
    t.decimal  "col_b_individuals_unitemized",                               precision: 12, scale: 2
    t.decimal  "col_b_individual_contribution_total",                        precision: 12, scale: 2
    t.decimal  "col_b_political_party_committees_receipts",                  precision: 12, scale: 2
    t.decimal  "col_b_other_political_committees_pacs",                      precision: 12, scale: 2
    t.decimal  "col_b_the_candidate",                                        precision: 12, scale: 2
    t.decimal  "col_b_total_contributions_other_than_loans",                 precision: 12, scale: 2
    t.decimal  "col_b_transfers_from_aff_other_party_cmttees",               precision: 12, scale: 2
    t.decimal  "col_b_received_from_or_guaranteed_by_cand",                  precision: 12, scale: 2
    t.decimal  "col_b_other_loans",                                          precision: 12, scale: 2
    t.decimal  "col_b_total_loans",                                          precision: 12, scale: 2
    t.decimal  "col_b_operating",                                            precision: 12, scale: 2
    t.decimal  "col_b_fundraising",                                          precision: 12, scale: 2
    t.decimal  "col_b_legal_and_accounting",                                 precision: 12, scale: 2
    t.decimal  "col_b_total_offsets_to_operating_expenditures",              precision: 12, scale: 2
    t.decimal  "col_b_other_receipts",                                       precision: 12, scale: 2
    t.decimal  "col_b_total_receipts",                                       precision: 12, scale: 2
    t.decimal  "col_b_operating_expenditures",                               precision: 12, scale: 2
    t.decimal  "col_b_transfers_to_other_authorized_committees",             precision: 12, scale: 2
    t.decimal  "col_b_fundraising_disbursements",                            precision: 12, scale: 2
    t.decimal  "col_b_exempt_legal_accounting_disbursement",                 precision: 12, scale: 2
    t.decimal  "col_b_made_or_guaranteed_by_the_candidate",                  precision: 12, scale: 2
    t.decimal  "col_b_other_repayments",                                     precision: 12, scale: 2
    t.decimal  "col_b_total_loan_repayments_made",                           precision: 12, scale: 2
    t.decimal  "col_b_individuals",                                          precision: 12, scale: 2
    t.decimal  "col_b_political_party_committees_refunds",                   precision: 12, scale: 2
    t.decimal  "col_b_other_political_committees",                           precision: 12, scale: 2
    t.decimal  "col_b_total_contributions_refunds",                          precision: 12, scale: 2
    t.decimal  "col_b_other_disbursements",                                  precision: 12, scale: 2
    t.decimal  "col_b_total_disbursements",                                  precision: 12, scale: 2
    t.decimal  "col_b_alabama",                                              precision: 12, scale: 2
    t.decimal  "col_b_alaska",                                               precision: 12, scale: 2
    t.decimal  "col_b_arizona",                                              precision: 12, scale: 2
    t.decimal  "col_b_arkansas",                                             precision: 12, scale: 2
    t.decimal  "col_b_california",                                           precision: 12, scale: 2
    t.decimal  "col_b_colorado",                                             precision: 12, scale: 2
    t.decimal  "col_b_connecticut",                                          precision: 12, scale: 2
    t.decimal  "col_b_delaware",                                             precision: 12, scale: 2
    t.decimal  "col_b_dist_of_columbia",                                     precision: 12, scale: 2
    t.decimal  "col_b_florida",                                              precision: 12, scale: 2
    t.decimal  "col_b_georgia",                                              precision: 12, scale: 2
    t.decimal  "col_b_hawaii",                                               precision: 12, scale: 2
    t.decimal  "col_b_idaho",                                                precision: 12, scale: 2
    t.decimal  "col_b_illinois",                                             precision: 12, scale: 2
    t.decimal  "col_b_indiana",                                              precision: 12, scale: 2
    t.decimal  "col_b_iowa",                                                 precision: 12, scale: 2
    t.decimal  "col_b_kansas",                                               precision: 12, scale: 2
    t.decimal  "col_b_kentucky",                                             precision: 12, scale: 2
    t.decimal  "col_b_louisiana",                                            precision: 12, scale: 2
    t.decimal  "col_b_maine",                                                precision: 12, scale: 2
    t.decimal  "col_b_maryland",                                             precision: 12, scale: 2
    t.decimal  "col_b_massachusetts",                                        precision: 12, scale: 2
    t.decimal  "col_b_michigan",                                             precision: 12, scale: 2
    t.decimal  "col_b_minnesota",                                            precision: 12, scale: 2
    t.decimal  "col_b_mississippi",                                          precision: 12, scale: 2
    t.decimal  "col_b_missouri",                                             precision: 12, scale: 2
    t.decimal  "col_b_montana",                                              precision: 12, scale: 2
    t.decimal  "col_b_nebraska",                                             precision: 12, scale: 2
    t.decimal  "col_b_nevada",                                               precision: 12, scale: 2
    t.decimal  "col_b_new_hampshire",                                        precision: 12, scale: 2
    t.decimal  "col_b_new_jersey",                                           precision: 12, scale: 2
    t.decimal  "col_b_new_mexico",                                           precision: 12, scale: 2
    t.decimal  "col_b_new_york",                                             precision: 12, scale: 2
    t.decimal  "col_b_north_carolina",                                       precision: 12, scale: 2
    t.decimal  "col_b_north_dakota",                                         precision: 12, scale: 2
    t.decimal  "col_b_ohio",                                                 precision: 12, scale: 2
    t.decimal  "col_b_oklahoma",                                             precision: 12, scale: 2
    t.decimal  "col_b_oregon",                                               precision: 12, scale: 2
    t.decimal  "col_b_pennsylvania",                                         precision: 12, scale: 2
    t.decimal  "col_b_rhode_island",                                         precision: 12, scale: 2
    t.decimal  "col_b_south_carolina",                                       precision: 12, scale: 2
    t.decimal  "col_b_south_dakota",                                         precision: 12, scale: 2
    t.decimal  "col_b_tennessee",                                            precision: 12, scale: 2
    t.decimal  "col_b_texas",                                                precision: 12, scale: 2
    t.decimal  "col_b_utah",                                                 precision: 12, scale: 2
    t.decimal  "col_b_vermont",                                              precision: 12, scale: 2
    t.decimal  "col_b_virginia",                                             precision: 12, scale: 2
    t.decimal  "col_b_washington",                                           precision: 12, scale: 2
    t.decimal  "col_b_west_virginia",                                        precision: 12, scale: 2
    t.decimal  "col_b_wisconsin",                                            precision: 12, scale: 2
    t.decimal  "col_b_wyoming",                                              precision: 12, scale: 2
    t.decimal  "col_b_puerto_rico",                                          precision: 12, scale: 2
    t.decimal  "col_b_guam",                                                 precision: 12, scale: 2
    t.decimal  "col_b_virgin_islands",                                       precision: 12, scale: 2
    t.decimal  "col_b_totals",                                               precision: 12, scale: 2
    t.string   "treasurer_name",                                 limit: 200
    t.string   "fec_record_type",                                limit: 1,                            default: "C"
  end

  add_index "fec_filing_f3p", ["committee_name"], name: "index_fec_filing_f3p_on_committee_name", using: :btree
  add_index "fec_filing_f3p", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3p", ["filer_committee_id_number"], name: "index_fec_filing_f3p_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f3p", ["treasurer_name"], name: "index_fec_filing_f3p_on_treasurer_name", using: :btree

  create_table "fec_filing_f3p31", force: true do |t|
    t.integer  "fec_record_number",                                                                 null: false, unsigned: true
    t.integer  "row_number",                                                                        null: false, unsigned: true
    t.integer  "lock_version",                                                        default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                      limit: 8
    t.string   "filer_committee_id_number",      limit: 9
    t.string   "transaction_id_number",          limit: 20
    t.string   "entity_type",                    limit: 3
    t.string   "contributor_organization_name",  limit: 200
    t.string   "contributor_last_name",          limit: 30
    t.string   "contributor_first_name",         limit: 20
    t.string   "contributor_middle_name",        limit: 20
    t.string   "contributor_prefix",             limit: 10
    t.string   "contributor_suffix",             limit: 10
    t.string   "contributor_street_1",           limit: 34
    t.string   "contributor_street_2",           limit: 34
    t.string   "contributor_city",               limit: 30
    t.string   "contributor_state",              limit: 2
    t.string   "contributor_zip_code",           limit: 9
    t.string   "election_code",                  limit: 5
    t.string   "item_description",               limit: 100
    t.date     "item_contribution_aquired_date"
    t.decimal  "item_fair_market_value",                     precision: 12, scale: 2
    t.string   "contributor_employer",           limit: 38
    t.string   "contributor_occupation",         limit: 38
    t.string   "memo_code",                      limit: 1
    t.string   "memo_text_description",          limit: 100
    t.string   "contributor_name",               limit: 200
    t.string   "transaction_code",               limit: 3
    t.string   "transaction_description",        limit: 40
    t.string   "fec_committee_id_number",        limit: 9
    t.string   "fec_candidate_id_number",        limit: 9
    t.string   "candidate_name",                 limit: 200
    t.string   "candidate_office",               limit: 1
    t.string   "candidate_state",                limit: 2
    t.string   "candidate_district",             limit: 2
    t.string   "conduit_name",                   limit: 200
    t.string   "conduit_street_1",               limit: 34
    t.string   "conduit_street_2",               limit: 34
    t.string   "conduit_city",                   limit: 30
    t.string   "conduit_state",                  limit: 2
    t.string   "conduit_zip_code",               limit: 9
    t.string   "fec_record_type",                limit: 1,                            default: "C"
  end

  add_index "fec_filing_f3p31", ["candidate_name"], name: "index_fec_filing_f3p31_on_candidate_name", using: :btree
  add_index "fec_filing_f3p31", ["conduit_name"], name: "index_fec_filing_f3p31_on_conduit_name", using: :btree
  add_index "fec_filing_f3p31", ["contributor_name"], name: "index_fec_filing_f3p31_on_contributor_name", using: :btree
  add_index "fec_filing_f3p31", ["contributor_organization_name"], name: "index_fec_filing_f3p31_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f3p31", ["fec_candidate_id_number"], name: "index_fec_filing_f3p31_on_fec_candidate_id_number", using: :btree
  add_index "fec_filing_f3p31", ["fec_committee_id_number"], name: "index_fec_filing_f3p31_on_fec_committee_id_number", using: :btree
  add_index "fec_filing_f3p31", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3p31", ["filer_committee_id_number"], name: "index_fec_filing_f3p31_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f3ps", force: true do |t|
    t.integer  "fec_record_number",                                                                           null: false, unsigned: true
    t.integer  "row_number",                                                                                  null: false, unsigned: true
    t.integer  "lock_version",                                                                  default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                  limit: 8
    t.string   "filer_committee_id_number",                  limit: 9
    t.date     "date_general_election"
    t.date     "date_day_after_general_election"
    t.decimal  "net_contributions",                                    precision: 12, scale: 2
    t.decimal  "net_expenditures",                                     precision: 12, scale: 2
    t.decimal  "federal_funds",                                        precision: 12, scale: 2
    t.decimal  "a_i_individuals_itemized",                             precision: 12, scale: 2
    t.decimal  "a_ii_individuals_unitemized",                          precision: 12, scale: 2
    t.decimal  "a_iii_individual_contribution_total",                  precision: 12, scale: 2
    t.decimal  "b_political_party_committees",                         precision: 12, scale: 2
    t.decimal  "c_other_political_committees_pacs",                    precision: 12, scale: 2
    t.decimal  "d_the_candidate",                                      precision: 12, scale: 2
    t.decimal  "e_total_contributions_other_than_loans",               precision: 12, scale: 2
    t.decimal  "transfers_from_aff_other_party_committees",            precision: 12, scale: 2
    t.decimal  "a_received_from_or_guaranteed_by_candidate",           precision: 12, scale: 2
    t.decimal  "b_other_loans",                                        precision: 12, scale: 2
    t.decimal  "c_total_loans",                                        precision: 12, scale: 2
    t.decimal  "a_operating",                                          precision: 12, scale: 2
    t.decimal  "b_fundraising",                                        precision: 12, scale: 2
    t.decimal  "c_legal_and_accounting",                               precision: 12, scale: 2
    t.decimal  "d_total_offsets_to_operating_expenditures",            precision: 12, scale: 2
    t.decimal  "other_receipts",                                       precision: 12, scale: 2
    t.decimal  "total_receipts",                                       precision: 12, scale: 2
    t.decimal  "operating_expenditures",                               precision: 12, scale: 2
    t.decimal  "transfers_to_other_authorized_committees",             precision: 12, scale: 2
    t.decimal  "fundraising_disbursements",                            precision: 12, scale: 2
    t.decimal  "exempt_legal_and_accounting_disbursements",            precision: 12, scale: 2
    t.decimal  "a_made_or_guaranteed_by_the_candidate",                precision: 12, scale: 2
    t.decimal  "b_other_repayments",                                   precision: 12, scale: 2
    t.decimal  "c_total_loan_repayments_made",                         precision: 12, scale: 2
    t.decimal  "a_individuals",                                        precision: 12, scale: 2
    t.decimal  "c_other_political_committees",                         precision: 12, scale: 2
    t.decimal  "d_total_contributions_refunds",                        precision: 12, scale: 2
    t.decimal  "other_disbursements",                                  precision: 12, scale: 2
    t.decimal  "total_disbursements",                                  precision: 12, scale: 2
    t.decimal  "alabama",                                              precision: 12, scale: 2
    t.decimal  "alaska",                                               precision: 12, scale: 2
    t.decimal  "arizona",                                              precision: 12, scale: 2
    t.decimal  "arkansas",                                             precision: 12, scale: 2
    t.decimal  "california",                                           precision: 12, scale: 2
    t.decimal  "colorado",                                             precision: 12, scale: 2
    t.decimal  "connecticut",                                          precision: 12, scale: 2
    t.decimal  "delaware",                                             precision: 12, scale: 2
    t.decimal  "dist_of_columbia",                                     precision: 12, scale: 2
    t.decimal  "florida",                                              precision: 12, scale: 2
    t.decimal  "georgia",                                              precision: 12, scale: 2
    t.decimal  "hawaii",                                               precision: 12, scale: 2
    t.decimal  "idaho",                                                precision: 12, scale: 2
    t.decimal  "illinois",                                             precision: 12, scale: 2
    t.decimal  "indiana",                                              precision: 12, scale: 2
    t.decimal  "iowa",                                                 precision: 12, scale: 2
    t.decimal  "kansas",                                               precision: 12, scale: 2
    t.decimal  "kentucky",                                             precision: 12, scale: 2
    t.decimal  "louisiana",                                            precision: 12, scale: 2
    t.decimal  "maine",                                                precision: 12, scale: 2
    t.decimal  "maryland",                                             precision: 12, scale: 2
    t.decimal  "massachusetts",                                        precision: 12, scale: 2
    t.decimal  "michigan",                                             precision: 12, scale: 2
    t.decimal  "minnesota",                                            precision: 12, scale: 2
    t.decimal  "mississippi",                                          precision: 12, scale: 2
    t.decimal  "missouri",                                             precision: 12, scale: 2
    t.decimal  "montana",                                              precision: 12, scale: 2
    t.decimal  "nebraska",                                             precision: 12, scale: 2
    t.decimal  "nevada",                                               precision: 12, scale: 2
    t.decimal  "new_hampshire",                                        precision: 12, scale: 2
    t.decimal  "new_jersey",                                           precision: 12, scale: 2
    t.decimal  "new_mexico",                                           precision: 12, scale: 2
    t.decimal  "new_york",                                             precision: 12, scale: 2
    t.decimal  "north_carolina",                                       precision: 12, scale: 2
    t.decimal  "north_dakota",                                         precision: 12, scale: 2
    t.decimal  "ohio",                                                 precision: 12, scale: 2
    t.decimal  "oklahoma",                                             precision: 12, scale: 2
    t.decimal  "oregon",                                               precision: 12, scale: 2
    t.decimal  "pennsylvania",                                         precision: 12, scale: 2
    t.decimal  "rhode_island",                                         precision: 12, scale: 2
    t.decimal  "south_carolina",                                       precision: 12, scale: 2
    t.decimal  "south_dakota",                                         precision: 12, scale: 2
    t.decimal  "tennessee",                                            precision: 12, scale: 2
    t.decimal  "texas",                                                precision: 12, scale: 2
    t.decimal  "utah",                                                 precision: 12, scale: 2
    t.decimal  "vermont",                                              precision: 12, scale: 2
    t.decimal  "virginia",                                             precision: 12, scale: 2
    t.decimal  "washington",                                           precision: 12, scale: 2
    t.decimal  "west_virginia",                                        precision: 12, scale: 2
    t.decimal  "wisconsin",                                            precision: 12, scale: 2
    t.decimal  "wyoming",                                              precision: 12, scale: 2
    t.decimal  "puerto_rico",                                          precision: 12, scale: 2
    t.decimal  "guam",                                                 precision: 12, scale: 2
    t.decimal  "virgin_islands",                                       precision: 12, scale: 2
    t.decimal  "totals",                                               precision: 12, scale: 2
    t.string   "fec_record_type",                            limit: 1,                          default: "C"
  end

  add_index "fec_filing_f3ps", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3ps", ["filer_committee_id_number"], name: "index_fec_filing_f3ps_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f3s", force: true do |t|
    t.integer  "fec_record_number",                                                                          null: false, unsigned: true
    t.integer  "row_number",                                                                                 null: false, unsigned: true
    t.integer  "lock_version",                                                                 default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                 limit: 8
    t.string   "filer_committee_id_number",                 limit: 9
    t.date     "date_general_election"
    t.date     "date_day_after_general_election"
    t.decimal  "a_total_contributions_no_loans",                      precision: 12, scale: 2
    t.decimal  "b_total_contribution_refunds",                        precision: 12, scale: 2
    t.decimal  "c_net_contributions",                                 precision: 12, scale: 2
    t.decimal  "a_total_operating_expenditures",                      precision: 12, scale: 2
    t.decimal  "b_total_offsets_to_operating_expenditures",           precision: 12, scale: 2
    t.decimal  "c_net_operating_expenditures",                        precision: 12, scale: 2
    t.decimal  "a_i_individuals_itemized",                            precision: 12, scale: 2
    t.decimal  "a_ii_individuals_unitemized",                         precision: 12, scale: 2
    t.decimal  "a_iii_individuals_total",                             precision: 12, scale: 2
    t.decimal  "b_political_party_committees",                        precision: 12, scale: 2
    t.decimal  "c_all_other_political_committees_pacs",               precision: 12, scale: 2
    t.decimal  "d_the_candidate",                                     precision: 12, scale: 2
    t.decimal  "e_total_contributions",                               precision: 12, scale: 2
    t.decimal  "transfers_from_other_auth_committees",                precision: 12, scale: 2
    t.decimal  "a_loans_made_or_guarn_by_the_candidate",              precision: 12, scale: 2
    t.decimal  "b_all_other_loans",                                   precision: 12, scale: 2
    t.decimal  "c_total_loans",                                       precision: 12, scale: 2
    t.decimal  "offsets_to_operating_expenditures",                   precision: 12, scale: 2
    t.decimal  "other_receipts",                                      precision: 12, scale: 2
    t.decimal  "total_receipts",                                      precision: 12, scale: 2
    t.decimal  "operating_expenditures",                              precision: 12, scale: 2
    t.decimal  "transfers_to_other_auth_committees",                  precision: 12, scale: 2
    t.decimal  "a_loan_repayment_by_candidate",                       precision: 12, scale: 2
    t.decimal  "b_loan_repayments_all_other_loans",                   precision: 12, scale: 2
    t.decimal  "c_total_loan_repayments",                             precision: 12, scale: 2
    t.decimal  "a_refund_individuals_other_than_pol_cmtes",           precision: 12, scale: 2
    t.decimal  "b_refund_political_party_committees",                 precision: 12, scale: 2
    t.decimal  "c_refund_other_political_committees",                 precision: 12, scale: 2
    t.decimal  "d_total_contributions_refunds",                       precision: 12, scale: 2
    t.decimal  "other_disbursements",                                 precision: 12, scale: 2
    t.decimal  "total_disbursements",                                 precision: 12, scale: 2
    t.string   "fec_record_type",                           limit: 1,                          default: "C"
  end

  add_index "fec_filing_f3s", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3s", ["filer_committee_id_number"], name: "index_fec_filing_f3s_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f3x", force: true do |t|
    t.integer  "fec_record_number",                                                                                     null: false, unsigned: true
    t.integer  "row_number",                                                                                            null: false, unsigned: true
    t.integer  "lock_version",                                                                            default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                          limit: 8
    t.string   "filer_committee_id_number",                          limit: 9
    t.string   "committee_name",                                     limit: 200
    t.string   "change_of_address",                                  limit: 1
    t.string   "street_1",                                           limit: 34
    t.string   "street_2",                                           limit: 34
    t.string   "city",                                               limit: 30
    t.string   "state",                                              limit: 2
    t.string   "zip_code",                                           limit: 9
    t.string   "report_code",                                        limit: 3
    t.string   "election_code",                                      limit: 5
    t.date     "date_of_election"
    t.string   "state_of_election",                                  limit: 2
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.string   "qualified_committee",                                limit: 1
    t.string   "treasurer_last_name",                                limit: 30
    t.string   "treasurer_first_name",                               limit: 20
    t.string   "treasurer_middle_name",                              limit: 20
    t.string   "treasurer_prefix",                                   limit: 10
    t.string   "treasurer_suffix",                                   limit: 10
    t.date     "date_signed"
    t.decimal  "col_a_cash_on_hand_beginning_period",                            precision: 12, scale: 2
    t.decimal  "col_a_total_receipts",                                           precision: 12, scale: 2
    t.decimal  "col_a_subtotal",                                                 precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements",                                      precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_close_of_period",                             precision: 12, scale: 2
    t.decimal  "col_a_debts_to",                                                 precision: 12, scale: 2
    t.decimal  "col_a_debts_by",                                                 precision: 12, scale: 2
    t.decimal  "col_a_individuals_itemized",                                     precision: 12, scale: 2
    t.decimal  "col_a_individuals_unitemized",                                   precision: 12, scale: 2
    t.decimal  "col_a_individual_contribution_total",                            precision: 12, scale: 2
    t.decimal  "col_a_political_party_committees",                               precision: 12, scale: 2
    t.decimal  "col_a_other_political_committees_pacs",                          precision: 12, scale: 2
    t.decimal  "col_a_total_contributions",                                      precision: 12, scale: 2
    t.decimal  "col_a_transfers_from_aff_other_party_cmttees",                   precision: 12, scale: 2
    t.decimal  "col_a_total_loans",                                              precision: 12, scale: 2
    t.decimal  "col_a_total_loan_repayments_received",                           precision: 12, scale: 2
    t.decimal  "col_a_offsets_to_expenditures",                                  precision: 12, scale: 2
    t.decimal  "col_a_total_contributions_refunds",                              precision: 12, scale: 2
    t.decimal  "col_a_other_federal_receipts",                                   precision: 12, scale: 2
    t.decimal  "col_a_transfers_from_nonfederal_h3",                             precision: 12, scale: 2
    t.decimal  "col_a_levin_funds",                                              precision: 12, scale: 2
    t.decimal  "col_a_total_nonfederal_transfers",                               precision: 12, scale: 2
    t.decimal  "col_a_total_federal_receipts",                                   precision: 12, scale: 2
    t.decimal  "col_a_shared_operating_expenditures_federal",                    precision: 12, scale: 2
    t.decimal  "col_a_shared_operating_expenditures_nonfederal",                 precision: 12, scale: 2
    t.decimal  "col_a_other_federal_operating_expenditures",                     precision: 12, scale: 2
    t.decimal  "col_a_total_operating_expenditures",                             precision: 12, scale: 2
    t.decimal  "col_a_transfers_to_affiliated",                                  precision: 12, scale: 2
    t.decimal  "col_a_contributions_to_candidates",                              precision: 12, scale: 2
    t.decimal  "col_a_independent_expenditures",                                 precision: 12, scale: 2
    t.decimal  "col_a_coordinated_expenditures_by_party_committees",             precision: 12, scale: 2
    t.decimal  "col_a_total_loan_repayments_made",                               precision: 12, scale: 2
    t.decimal  "col_a_loans_made",                                               precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_individuals",                                   precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_party_committees",                              precision: 12, scale: 2
    t.decimal  "col_a_refunds_to_other_committees",                              precision: 12, scale: 2
    t.decimal  "col_a_total_refunds",                                            precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements",                                      precision: 12, scale: 2
    t.decimal  "col_a_federal_election_activity_federal_share",                  precision: 12, scale: 2
    t.decimal  "col_a_federal_election_activity_levin_share",                    precision: 12, scale: 2
    t.decimal  "col_a_federal_election_activity_all_federal",                    precision: 12, scale: 2
    t.decimal  "col_a_federal_election_activity_total",                          precision: 12, scale: 2
    t.decimal  "col_a_total_federal_disbursements",                              precision: 12, scale: 2
    t.decimal  "col_a_net_contributions",                                        precision: 12, scale: 2
    t.decimal  "col_a_total_federal_operating_expenditures",                     precision: 12, scale: 2
    t.decimal  "col_a_total_offsets_to_expenditures",                            precision: 12, scale: 2
    t.decimal  "col_a_net_operating_expenditures",                               precision: 12, scale: 2
    t.decimal  "col_b_cash_on_hand_jan_1",                                       precision: 12, scale: 2
    t.integer  "col_b_year",                                                                                                         unsigned: true
    t.decimal  "col_b_total_receipts",                                           precision: 12, scale: 2
    t.decimal  "col_b_subtotal",                                                 precision: 12, scale: 2
    t.decimal  "col_b_total_disbursements",                                      precision: 12, scale: 2
    t.decimal  "col_b_cash_on_hand_close_of_period",                             precision: 12, scale: 2
    t.decimal  "col_b_individuals_itemized",                                     precision: 12, scale: 2
    t.decimal  "col_b_individuals_unitemized",                                   precision: 12, scale: 2
    t.decimal  "col_b_individual_contribution_total",                            precision: 12, scale: 2
    t.decimal  "col_b_political_party_committees",                               precision: 12, scale: 2
    t.decimal  "col_b_other_political_committees_pacs",                          precision: 12, scale: 2
    t.decimal  "col_b_total_contributions",                                      precision: 12, scale: 2
    t.decimal  "col_b_transfers_from_aff_other_party_cmttees",                   precision: 12, scale: 2
    t.decimal  "col_b_total_loans",                                              precision: 12, scale: 2
    t.decimal  "col_b_total_loan_repayments_received",                           precision: 12, scale: 2
    t.decimal  "col_b_offsets_to_expenditures",                                  precision: 12, scale: 2
    t.decimal  "col_b_total_contributions_refunds",                              precision: 12, scale: 2
    t.decimal  "col_b_other_federal_receipts",                                   precision: 12, scale: 2
    t.decimal  "col_b_transfers_from_nonfederal_h3",                             precision: 12, scale: 2
    t.decimal  "col_b_levin_funds",                                              precision: 12, scale: 2
    t.decimal  "col_b_total_nonfederal_transfers",                               precision: 12, scale: 2
    t.decimal  "col_b_total_federal_receipts",                                   precision: 12, scale: 2
    t.decimal  "col_b_shared_operating_expenditures_federal",                    precision: 12, scale: 2
    t.decimal  "col_b_shared_operating_expenditures_nonfederal",                 precision: 12, scale: 2
    t.decimal  "col_b_other_federal_operating_expenditures",                     precision: 12, scale: 2
    t.decimal  "col_b_total_operating_expenditures",                             precision: 12, scale: 2
    t.decimal  "col_b_transfers_to_affiliated",                                  precision: 12, scale: 2
    t.decimal  "col_b_contributions_to_candidates",                              precision: 12, scale: 2
    t.decimal  "col_b_independent_expenditures",                                 precision: 12, scale: 2
    t.decimal  "col_b_coordinated_expenditures_by_party_committees",             precision: 12, scale: 2
    t.decimal  "col_b_total_loan_repayments_made",                               precision: 12, scale: 2
    t.decimal  "col_b_loans_made",                                               precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_individuals",                                   precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_party_committees",                              precision: 12, scale: 2
    t.decimal  "col_b_refunds_to_other_committees",                              precision: 12, scale: 2
    t.decimal  "col_b_total_refunds",                                            precision: 12, scale: 2
    t.decimal  "col_b_other_disbursements",                                      precision: 12, scale: 2
    t.decimal  "col_b_federal_election_activity_federal_share",                  precision: 12, scale: 2
    t.decimal  "col_b_federal_election_activity_levin_share",                    precision: 12, scale: 2
    t.decimal  "col_b_federal_election_activity_all_federal",                    precision: 12, scale: 2
    t.decimal  "col_b_federal_election_activity_total",                          precision: 12, scale: 2
    t.decimal  "col_b_total_federal_disbursements",                              precision: 12, scale: 2
    t.decimal  "col_b_net_contributions",                                        precision: 12, scale: 2
    t.decimal  "col_b_total_federal_operating_expenditures",                     precision: 12, scale: 2
    t.decimal  "col_b_total_offsets_to_expenditures",                            precision: 12, scale: 2
    t.decimal  "col_b_net_operating_expenditures",                               precision: 12, scale: 2
    t.string   "treasurer_name",                                     limit: 200
    t.string   "fec_record_type",                                    limit: 1,                            default: "C"
  end

  add_index "fec_filing_f3x", ["committee_name"], name: "index_fec_filing_f3x_on_committee_name", using: :btree
  add_index "fec_filing_f3x", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f3x", ["filer_committee_id_number"], name: "index_fec_filing_f3x_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f3x", ["treasurer_name"], name: "index_fec_filing_f3x_on_treasurer_name", using: :btree

  create_table "fec_filing_f4", force: true do |t|
    t.integer  "fec_record_number",                                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                     limit: 8
    t.string   "filer_committee_id_number",                     limit: 9
    t.string   "committee_name",                                limit: 200
    t.string   "street_1",                                      limit: 34
    t.string   "street_2",                                      limit: 34
    t.string   "city",                                          limit: 30
    t.string   "state",                                         limit: 2
    t.string   "zip_code",                                      limit: 9
    t.string   "committee_type",                                limit: 1
    t.string   "committee_type_description",                    limit: 40
    t.string   "report_code",                                   limit: 3
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.string   "treasurer_last_name",                           limit: 30
    t.string   "treasurer_first_name",                          limit: 20
    t.string   "treasurer_middle_name",                         limit: 20
    t.string   "treasurer_prefix",                              limit: 10
    t.string   "treasurer_suffix",                              limit: 10
    t.date     "date_signed"
    t.decimal  "col_a_cash_on_hand_beginning_reporting_period",             precision: 12, scale: 2
    t.decimal  "col_a_total_receipts",                                      precision: 12, scale: 2
    t.decimal  "col_a_subtotal",                                            precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements",                                 precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_close_of_period",                        precision: 12, scale: 2
    t.decimal  "col_a_debts_to",                                            precision: 12, scale: 2
    t.decimal  "col_a_debts_by",                                            precision: 12, scale: 2
    t.decimal  "col_a_convention_expenditures",                             precision: 12, scale: 2
    t.decimal  "col_a_convention_refunds",                                  precision: 12, scale: 2
    t.decimal  "col_a_expenditures_subject_to_limits",                      precision: 12, scale: 2
    t.decimal  "col_a_prior_expenditures_subject_to_limits",                precision: 12, scale: 2
    t.decimal  "col_a_federal_funds",                                       precision: 12, scale: 2
    t.decimal  "col_a_contributions_itemized",                              precision: 12, scale: 2
    t.decimal  "col_a_contributions_unitemized",                            precision: 12, scale: 2
    t.decimal  "col_a_contributions_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_b_transfers_from_affiliated",                           precision: 12, scale: 2
    t.decimal  "col_a_loans_received",                                      precision: 12, scale: 2
    t.decimal  "col_a_loan_repayments_received",                            precision: 12, scale: 2
    t.decimal  "col_a_loan_receipts_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_a_convention_refunds_itemized",                         precision: 12, scale: 2
    t.decimal  "col_a_convention_refunds_unitemized",                       precision: 12, scale: 2
    t.decimal  "col_a_convention_refunds_subtotal",                         precision: 12, scale: 2
    t.decimal  "col_a_other_refunds_itemized",                              precision: 12, scale: 2
    t.decimal  "col_a_other_refunds_unitemized",                            precision: 12, scale: 2
    t.decimal  "col_a_other_refunds_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_a_other_income_itemized",                               precision: 12, scale: 2
    t.decimal  "col_a_other_income_unitemized",                             precision: 12, scale: 2
    t.decimal  "col_a_other_income_subtotal",                               precision: 12, scale: 2
    t.decimal  "col_a_convention_expenses_itemized",                        precision: 12, scale: 2
    t.decimal  "col_a_convention_expenses_unitemized",                      precision: 12, scale: 2
    t.decimal  "col_a_convention_expenses_subtotal",                        precision: 12, scale: 2
    t.decimal  "col_a_transfers_to_affiliated",                             precision: 12, scale: 2
    t.decimal  "col_a_loans_made",                                          precision: 12, scale: 2
    t.decimal  "col_a_loan_repayments_made",                                precision: 12, scale: 2
    t.decimal  "col_a_loan_disbursements_subtotal",                         precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements_itemized",                        precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements_unitemized",                      precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements_subtotal",                        precision: 12, scale: 2
    t.integer  "col_b_cash_on_hand_beginning_year",                                                                             unsigned: true
    t.integer  "col_b_beginning_year",                                                                                          unsigned: true
    t.decimal  "col_b_total_receipts",                                      precision: 12, scale: 2
    t.decimal  "col_b_subtotal",                                            precision: 12, scale: 2
    t.decimal  "col_b_total_disbursements",                                 precision: 12, scale: 2
    t.decimal  "col_b_cash_on_hand_close_of_period",                        precision: 12, scale: 2
    t.decimal  "col_b_convention_expenditures",                             precision: 12, scale: 2
    t.decimal  "col_b_convention_refunds",                                  precision: 12, scale: 2
    t.decimal  "col_b_expenditures_subject_to_limits",                      precision: 12, scale: 2
    t.decimal  "col_b_prior_expendiutres_subject_to_limits",                precision: 12, scale: 2
    t.decimal  "col_b_total_expenditures_subject_to_limits",                precision: 12, scale: 2
    t.decimal  "col_b_federal_funds",                                       precision: 12, scale: 2
    t.decimal  "col_b_contributions_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_b_loan_receipts_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_b_convention_refunds_subtotal",                         precision: 12, scale: 2
    t.decimal  "col_b_other_refunds_subtotal",                              precision: 12, scale: 2
    t.decimal  "col_b_other_income_subtotal",                               precision: 12, scale: 2
    t.decimal  "col_b_convention_expenses_subtotal",                        precision: 12, scale: 2
    t.decimal  "col_b_transfers_to_affiliated",                             precision: 12, scale: 2
    t.decimal  "col_b_loan_disbursements_subtotal",                         precision: 12, scale: 2
    t.decimal  "col_b_other_disbursements_subtotal",                        precision: 12, scale: 2
    t.decimal  "col_a_total_expenditures_subject_to_limits",                precision: 12, scale: 2
    t.string   "treasurer_name",                                limit: 200
    t.string   "fec_record_type",                               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f4", ["committee_name"], name: "index_fec_filing_f4_on_committee_name", using: :btree
  add_index "fec_filing_f4", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f4", ["filer_committee_id_number"], name: "index_fec_filing_f4_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f4", ["treasurer_name"], name: "index_fec_filing_f4_on_treasurer_name", using: :btree

  create_table "fec_filing_f5", force: true do |t|
    t.integer  "fec_record_number",                                                                 null: false, unsigned: true
    t.integer  "row_number",                                                                        null: false, unsigned: true
    t.integer  "lock_version",                                                        default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                      limit: 8
    t.string   "filer_committee_id_number",      limit: 9
    t.string   "entity_type",                    limit: 3
    t.string   "organization_name",              limit: 200
    t.string   "individual_last_name",           limit: 30
    t.string   "individual_first_name",          limit: 20
    t.string   "individual_middle_name",         limit: 20
    t.string   "individual_prefix",              limit: 10
    t.string   "individual_suffix",              limit: 10
    t.string   "change_of_address",              limit: 1
    t.string   "street_1",                       limit: 34
    t.string   "street_2",                       limit: 34
    t.string   "city",                           limit: 30
    t.string   "state",                          limit: 2
    t.string   "zip_code",                       limit: 9
    t.string   "individual_occupation",          limit: 38
    t.string   "individual_employer",            limit: 38
    t.string   "report_code",                    limit: 3
    t.string   "report_type",                    limit: 3
    t.date     "original_amendment_date"
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.decimal  "total_contribution",                         precision: 12, scale: 2
    t.decimal  "total_independent_expenditure",              precision: 12, scale: 2
    t.string   "person_completing_last_name",    limit: 30
    t.string   "person_completing_first_name",   limit: 20
    t.string   "person_completing_middle_name",  limit: 20
    t.string   "person_completing_prefix",       limit: 10
    t.string   "person_completing_suffix",       limit: 10
    t.date     "date_signed"
    t.string   "qualified_nonprofit",            limit: 1
    t.string   "committee_name",                 limit: 200
    t.string   "person_completing_name",         limit: 200
    t.string   "report_pgi",                     limit: 5
    t.date     "election_date"
    t.string   "election_state",                 limit: 2
    t.date     "date_notarized"
    t.date     "date_notary_commission_expires"
    t.string   "notary_name",                    limit: 200
    t.string   "fec_record_type",                limit: 1,                            default: "C"
  end

  add_index "fec_filing_f5", ["committee_name"], name: "index_fec_filing_f5_on_committee_name", using: :btree
  add_index "fec_filing_f5", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f5", ["filer_committee_id_number"], name: "index_fec_filing_f5_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f5", ["notary_name"], name: "index_fec_filing_f5_on_notary_name", using: :btree
  add_index "fec_filing_f5", ["organization_name"], name: "index_fec_filing_f5_on_organization_name", using: :btree
  add_index "fec_filing_f5", ["person_completing_name"], name: "index_fec_filing_f5_on_person_completing_name", using: :btree

  create_table "fec_filing_f56", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip_code",          limit: 9
    t.string   "contributor_fec_id",            limit: 9
    t.date     "contribution_date"
    t.decimal  "contribution_amount",                       precision: 12, scale: 2
    t.string   "contributor_employer",          limit: 38
    t.string   "contributor_occupation",        limit: 38
    t.string   "contributor_name",              limit: 200
    t.string   "candidate_id",                  limit: 9
    t.string   "candidate_name",                limit: 200
    t.string   "candidate_office",              limit: 1
    t.string   "candidate_state",               limit: 2
    t.string   "candidate_district",            limit: 2
    t.string   "conduit_name",                  limit: 200
    t.string   "conduit_street_1",              limit: 34
    t.string   "conduit_street_2",              limit: 34
    t.string   "conduit_city",                  limit: 30
    t.string   "conduit_state",                 limit: 2
    t.string   "conduit_zip_code",              limit: 9
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f56", ["candidate_name"], name: "index_fec_filing_f56_on_candidate_name", using: :btree
  add_index "fec_filing_f56", ["conduit_name"], name: "index_fec_filing_f56_on_conduit_name", using: :btree
  add_index "fec_filing_f56", ["contributor_name"], name: "index_fec_filing_f56_on_contributor_name", using: :btree
  add_index "fec_filing_f56", ["contributor_organization_name"], name: "index_fec_filing_f56_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f56", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f56", ["filer_committee_id_number"], name: "index_fec_filing_f56_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f57", force: true do |t|
    t.integer  "fec_record_number",                                                                     null: false, unsigned: true
    t.integer  "row_number",                                                                            null: false, unsigned: true
    t.integer  "lock_version",                                                            default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                          limit: 8
    t.string   "filer_committee_id_number",          limit: 9
    t.string   "transaction_id_number",              limit: 20
    t.string   "entity_type",                        limit: 3
    t.string   "payee_organization_name",            limit: 200
    t.string   "payee_last_name",                    limit: 30
    t.string   "payee_first_name",                   limit: 20
    t.string   "payee_middle_name",                  limit: 20
    t.string   "payee_prefix",                       limit: 10
    t.string   "payee_suffix",                       limit: 10
    t.string   "payee_street_1",                     limit: 34
    t.string   "payee_street_2",                     limit: 34
    t.string   "payee_city",                         limit: 30
    t.string   "payee_state",                        limit: 2
    t.string   "payee_zip_code",                     limit: 9
    t.string   "election_code",                      limit: 5
    t.string   "election_other_description",         limit: 20
    t.date     "dissemination_date"
    t.decimal  "expenditure_amount",                             precision: 12, scale: 2
    t.decimal  "calendar_y_t_d_per_election_office",             precision: 12, scale: 2
    t.string   "expenditure_purpose_descrip",        limit: 100
    t.string   "category_code",                      limit: 3
    t.string   "payee_cmtte_fec_id_number",          limit: 9
    t.string   "support_oppose_code",                limit: 3
    t.string   "candidate_id_number",                limit: 9
    t.string   "candidate_last_name",                limit: 30
    t.string   "candidate_first_name",               limit: 20
    t.string   "candidate_middle_name",              limit: 20
    t.string   "candidate_prefix",                   limit: 10
    t.string   "candidate_suffix",                   limit: 10
    t.string   "candidate_office",                   limit: 1
    t.string   "candidate_state",                    limit: 2
    t.string   "candidate_district",                 limit: 2
    t.string   "expenditure_purpose_code",           limit: 3
    t.string   "payee_name",                         limit: 200
    t.string   "candidate_name",                     limit: 200
    t.string   "conduit_name",                       limit: 200
    t.string   "conduit_street_1",                   limit: 34
    t.string   "conduit_street_2",                   limit: 34
    t.string   "conduit_city",                       limit: 30
    t.string   "conduit_state",                      limit: 2
    t.string   "conduit_zip_code",                   limit: 9
    t.string   "amended_code",                       limit: 1
    t.string   "fec_record_type",                    limit: 1,                            default: "C"
  end

  add_index "fec_filing_f57", ["candidate_id_number"], name: "index_fec_filing_f57_on_candidate_id_number", using: :btree
  add_index "fec_filing_f57", ["candidate_name"], name: "index_fec_filing_f57_on_candidate_name", using: :btree
  add_index "fec_filing_f57", ["conduit_name"], name: "index_fec_filing_f57_on_conduit_name", using: :btree
  add_index "fec_filing_f57", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f57", ["filer_committee_id_number"], name: "index_fec_filing_f57_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f57", ["payee_cmtte_fec_id_number"], name: "index_fec_filing_f57_on_payee_cmtte_fec_id_number", using: :btree
  add_index "fec_filing_f57", ["payee_name"], name: "index_fec_filing_f57_on_payee_name", using: :btree
  add_index "fec_filing_f57", ["payee_organization_name"], name: "index_fec_filing_f57_on_payee_organization_name", using: :btree

  create_table "fec_filing_f6", force: true do |t|
    t.integer  "fec_record_number",                                   null: false, unsigned: true
    t.integer  "row_number",                                          null: false, unsigned: true
    t.integer  "lock_version",                          default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.date     "original_amendment_date"
    t.string   "committee_name",            limit: 200
    t.string   "street_1",                  limit: 34
    t.string   "street_2",                  limit: 34
    t.string   "city",                      limit: 30
    t.string   "state",                     limit: 2
    t.string   "zip_code",                  limit: 9
    t.string   "candidate_id_number",       limit: 9
    t.string   "candidate_last_name",       limit: 30
    t.string   "candidate_first_name",      limit: 20
    t.string   "candidate_middle_name",     limit: 20
    t.string   "candidate_prefix",          limit: 10
    t.string   "candidate_suffix",          limit: 10
    t.string   "candidate_office",          limit: 1
    t.string   "candidate_state",           limit: 2
    t.string   "candidate_district",        limit: 2
    t.string   "signer_last_name",          limit: 30
    t.string   "signer_first_name",         limit: 20
    t.string   "signer_middle_name",        limit: 20
    t.string   "signer_prefix",             limit: 10
    t.string   "signer_suffix",             limit: 10
    t.date     "date_signed"
    t.string   "candidate_name",            limit: 200
    t.string   "fec_record_type",           limit: 1,   default: "C"
  end

  add_index "fec_filing_f6", ["candidate_id_number"], name: "index_fec_filing_f6_on_candidate_id_number", using: :btree
  add_index "fec_filing_f6", ["candidate_name"], name: "index_fec_filing_f6_on_candidate_name", using: :btree
  add_index "fec_filing_f6", ["committee_name"], name: "index_fec_filing_f6_on_committee_name", using: :btree
  add_index "fec_filing_f6", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f6", ["filer_committee_id_number"], name: "index_fec_filing_f6_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f65", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip_code",          limit: 9
    t.string   "contributor_fec_id",            limit: 9
    t.date     "contribution_date"
    t.decimal  "contribution_amount",                       precision: 12, scale: 2
    t.string   "contributor_employer",          limit: 38
    t.string   "contributor_occupation",        limit: 38
    t.string   "contributor_name",              limit: 200
    t.string   "candidate_id",                  limit: 9
    t.string   "candidate_name",                limit: 200
    t.string   "candidate_office",              limit: 1
    t.string   "candidate_state",               limit: 2
    t.string   "candidate_district",            limit: 2
    t.string   "conduit_name",                  limit: 200
    t.string   "conduit_street_1",              limit: 34
    t.string   "conduit_street_2",              limit: 34
    t.string   "conduit_city",                  limit: 30
    t.string   "conduit_state",                 limit: 2
    t.string   "conduit_zip_code",              limit: 9
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f65", ["candidate_name"], name: "index_fec_filing_f65_on_candidate_name", using: :btree
  add_index "fec_filing_f65", ["conduit_name"], name: "index_fec_filing_f65_on_conduit_name", using: :btree
  add_index "fec_filing_f65", ["contributor_name"], name: "index_fec_filing_f65_on_contributor_name", using: :btree
  add_index "fec_filing_f65", ["contributor_organization_name"], name: "index_fec_filing_f65_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f65", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f65", ["filer_committee_id_number"], name: "index_fec_filing_f65_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f7", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "organization_name",             limit: 200
    t.string   "street_1",                      limit: 34
    t.string   "street_2",                      limit: 34
    t.string   "city",                          limit: 30
    t.string   "state",                         limit: 2
    t.string   "zip_code",                      limit: 9
    t.string   "organization_type",             limit: 1
    t.string   "report_code",                   limit: 3
    t.date     "election_date"
    t.string   "election_state",                limit: 2
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.decimal  "total_costs",                               precision: 12, scale: 2
    t.string   "person_designated_last_name",   limit: 30
    t.string   "person_designated_first_name",  limit: 20
    t.string   "person_designated_middle_name", limit: 20
    t.string   "person_designated_prefix",      limit: 10
    t.string   "person_designated_suffix",      limit: 10
    t.string   "person_designated_title",       limit: 20
    t.date     "date_signed"
    t.string   "person_designated_name",        limit: 200
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f7", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f7", ["filer_committee_id_number"], name: "index_fec_filing_f7_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f7", ["organization_name"], name: "index_fec_filing_f7_on_organization_name", using: :btree
  add_index "fec_filing_f7", ["person_designated_name"], name: "index_fec_filing_f7_on_person_designated_name", using: :btree

  create_table "fec_filing_f76", force: true do |t|
    t.integer  "fec_record_number",                                                                 null: false, unsigned: true
    t.integer  "row_number",                                                                        null: false, unsigned: true
    t.integer  "lock_version",                                                        default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                      limit: 8
    t.string   "filer_committee_id_number",      limit: 9
    t.string   "transaction_id",                 limit: 20
    t.string   "communication_type",             limit: 2
    t.string   "communication_type_description", limit: 40
    t.string   "communication_class",            limit: 1
    t.date     "communication_date"
    t.decimal  "communication_cost",                         precision: 12, scale: 2
    t.string   "election_code",                  limit: 5
    t.string   "election_other_description",     limit: 20
    t.string   "support_oppose_code",            limit: 3
    t.string   "candidate_id_number",            limit: 9
    t.string   "candidate_last_name",            limit: 30
    t.string   "candidate_first_name",           limit: 20
    t.string   "candidate_middle_name",          limit: 20
    t.string   "candidate_prefix",               limit: 10
    t.string   "candidate_suffix",               limit: 10
    t.string   "candidate_office",               limit: 1
    t.string   "candidate_state",                limit: 2
    t.string   "candidate_district",             limit: 2
    t.string   "candidate_name",                 limit: 200
    t.string   "fec_record_type",                limit: 1,                            default: "C"
  end

  add_index "fec_filing_f76", ["candidate_id_number"], name: "index_fec_filing_f76_on_candidate_id_number", using: :btree
  add_index "fec_filing_f76", ["candidate_name"], name: "index_fec_filing_f76_on_candidate_name", using: :btree
  add_index "fec_filing_f76", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f76", ["filer_committee_id_number"], name: "index_fec_filing_f76_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f9", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "entity_type",                   limit: 3
    t.string   "organization_name",             limit: 200
    t.string   "individual_last_name",          limit: 30
    t.string   "individual_first_name",         limit: 20
    t.string   "individual_middle_name",        limit: 20
    t.string   "individual_prefix",             limit: 10
    t.string   "individual_suffix",             limit: 10
    t.string   "change_of_address",             limit: 1
    t.string   "street_1",                      limit: 34
    t.string   "street_2",                      limit: 34
    t.string   "city",                          limit: 30
    t.string   "state",                         limit: 2
    t.string   "zip_code",                      limit: 9
    t.string   "individual_employer",           limit: 38
    t.string   "individual_occupation",         limit: 38
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.date     "date_public_distribution"
    t.string   "communication_title",           limit: 40
    t.string   "filer_code",                    limit: 3
    t.string   "filer_code_description",        limit: 20
    t.string   "segregated_bank_account",       limit: 1
    t.string   "custodian_last_name",           limit: 30
    t.string   "custodian_first_name",          limit: 20
    t.string   "custodian_middle_name",         limit: 20
    t.string   "custodian_prefix",              limit: 10
    t.string   "custodian_suffix",              limit: 10
    t.string   "custodian_street_1",            limit: 34
    t.string   "custodian_street_2",            limit: 34
    t.string   "custodian_city",                limit: 30
    t.string   "custodian_state",               limit: 2
    t.string   "custodian_zip_code",            limit: 9
    t.string   "custodian_employer",            limit: 38
    t.string   "custodian_occupation",          limit: 38
    t.decimal  "total_donations",                           precision: 12, scale: 2
    t.decimal  "total_disbursements",                       precision: 12, scale: 2
    t.string   "person_completing_last_name",   limit: 30
    t.string   "person_completing_first_name",  limit: 20
    t.string   "person_completing_middle_name", limit: 20
    t.string   "person_completing_prefix",      limit: 10
    t.string   "person_completing_suffix",      limit: 10
    t.date     "date_signed"
    t.string   "qualified_non_profit",          limit: 1
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f9", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f9", ["filer_committee_id_number"], name: "index_fec_filing_f9_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f9", ["organization_name"], name: "index_fec_filing_f9_on_organization_name", using: :btree

  create_table "fec_filing_f91", force: true do |t|
    t.integer  "fec_record_number",                                  null: false, unsigned: true
    t.integer  "row_number",                                         null: false, unsigned: true
    t.integer  "lock_version",                         default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "transaction_id",            limit: 20
    t.string   "controller_last_name",      limit: 30
    t.string   "controller_first_name",     limit: 20
    t.string   "controller_middle_name",    limit: 20
    t.string   "controller_prefix",         limit: 10
    t.string   "controller_suffix",         limit: 10
    t.string   "controller_street_1",       limit: 34
    t.string   "controller_street_2",       limit: 34
    t.string   "controller_city",           limit: 30
    t.string   "controller_state",          limit: 2
    t.string   "controller_zip_code",       limit: 9
    t.string   "controller_employer",       limit: 38
    t.string   "controller_occupation",     limit: 38
    t.string   "amended_cd",                limit: 1
    t.string   "fec_record_type",           limit: 1,  default: "C"
  end

  add_index "fec_filing_f91", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f91", ["filer_committee_id_number"], name: "index_fec_filing_f91_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f92", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip_code",          limit: 9
    t.date     "contribution_date"
    t.decimal  "contribution_amount",                       precision: 12, scale: 2
    t.string   "contributor_employer",          limit: 38
    t.string   "contributor_occupation",        limit: 38
    t.string   "transaction_type",              limit: 3
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f92", ["contributor_organization_name"], name: "index_fec_filing_f92_on_contributor_organization_name", using: :btree
  add_index "fec_filing_f92", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f92", ["filer_committee_id_number"], name: "index_fec_filing_f92_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f93", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "entity_type",                   limit: 3
    t.string   "payee_organization_name",       limit: 200
    t.string   "payee_last_name",               limit: 30
    t.string   "payee_first_name",              limit: 20
    t.string   "payee_middle_name",             limit: 20
    t.string   "payee_prefix",                  limit: 10
    t.string   "payee_suffix",                  limit: 10
    t.string   "payee_street_1",                limit: 34
    t.string   "payee_street_2",                limit: 34
    t.string   "payee_city",                    limit: 30
    t.string   "payee_state",                   limit: 2
    t.string   "payee_zip_code",                limit: 9
    t.string   "election_code",                 limit: 5
    t.string   "election_other_description",    limit: 20
    t.date     "expenditure_date"
    t.decimal  "expenditure_amount",                        precision: 12, scale: 2
    t.string   "expenditure_purpose_descrip",   limit: 100
    t.string   "payee_employer",                limit: 38
    t.string   "payee_occupation",              limit: 38
    t.date     "communication_date"
    t.string   "expenditure_purpose_code",      limit: 3
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_f93", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f93", ["filer_committee_id_number"], name: "index_fec_filing_f93_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f93", ["payee_organization_name"], name: "index_fec_filing_f93_on_payee_organization_name", using: :btree

  create_table "fec_filing_f94", force: true do |t|
    t.integer  "fec_record_number",                                       null: false, unsigned: true
    t.integer  "row_number",                                              null: false, unsigned: true
    t.integer  "lock_version",                              default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "candidate_id_number",           limit: 9
    t.string   "candidate_last_name",           limit: 30
    t.string   "candidate_first_name",          limit: 20
    t.string   "candidate_middle_name",         limit: 20
    t.string   "candidate_prefix",              limit: 10
    t.string   "candidate_suffix",              limit: 10
    t.string   "candidate_office",              limit: 1
    t.string   "candidate_state",               limit: 2
    t.string   "candidate_district",            limit: 2
    t.string   "election_code",                 limit: 5
    t.string   "election_other_description",    limit: 20
    t.string   "candidate_name",                limit: 200
    t.string   "fec_record_type",               limit: 1,   default: "C"
  end

  add_index "fec_filing_f94", ["candidate_id_number"], name: "index_fec_filing_f94_on_candidate_id_number", using: :btree
  add_index "fec_filing_f94", ["candidate_name"], name: "index_fec_filing_f94_on_candidate_name", using: :btree
  add_index "fec_filing_f94", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f94", ["filer_committee_id_number"], name: "index_fec_filing_f94_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_f99", force: true do |t|
    t.integer  "fec_record_number",                                   null: false, unsigned: true
    t.integer  "row_number",                                          null: false, unsigned: true
    t.integer  "lock_version",                          default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "committee_name",            limit: 200
    t.string   "street_1",                  limit: 34
    t.string   "street_2",                  limit: 34
    t.string   "city",                      limit: 30
    t.string   "state",                     limit: 2
    t.string   "zip_code",                  limit: 9
    t.string   "treasurer_last_name",       limit: 30
    t.string   "treasurer_first_name",      limit: 20
    t.string   "treasurer_middle_name",     limit: 20
    t.string   "treasurer_prefix",          limit: 10
    t.string   "treasurer_suffix",          limit: 10
    t.date     "date_signed"
    t.string   "text_code",                 limit: 3
    t.text     "text"
    t.string   "treasurer_name",            limit: 200
    t.string   "fec_record_type",           limit: 1,   default: "C"
  end

  add_index "fec_filing_f99", ["committee_name"], name: "index_fec_filing_f99_on_committee_name", using: :btree
  add_index "fec_filing_f99", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_f99", ["filer_committee_id_number"], name: "index_fec_filing_f99_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_f99", ["treasurer_name"], name: "index_fec_filing_f99_on_treasurer_name", using: :btree

  create_table "fec_filing_h1", force: true do |t|
    t.integer  "fec_record_number",                                                                                        null: false, unsigned: true
    t.integer  "row_number",                                                                                               null: false, unsigned: true
    t.integer  "lock_version",                                                                               default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                              limit: 8
    t.string   "filer_committee_id_number",                              limit: 9
    t.string   "transaction_id",                                         limit: 20
    t.string   "presidential_only_election_year",                        limit: 1
    t.string   "presidential_senate_election_year",                      limit: 1
    t.string   "senate_only_election_year",                              limit: 1
    t.string   "non_presidential_non_senate_election_year",              limit: 1
    t.decimal  "flat_minimum_federal_percentage",                                   precision: 8,  scale: 5
    t.decimal  "federal_percent",                                                   precision: 8,  scale: 5
    t.decimal  "nonfederal_percent",                                                precision: 8,  scale: 5
    t.string   "administrative_ratio_applies",                           limit: 1
    t.string   "generic_voter_drive_ratio_applies",                      limit: 1
    t.string   "public_communications_referencing_party_ratio_applies",  limit: 1
    t.decimal  "national_party_committee_percentage",                               precision: 8,  scale: 5
    t.decimal  "hsp_committees_minimum_federal_percentage",                         precision: 8,  scale: 5
    t.decimal  "hsp_committees_percentage_federal_candidate_support",               precision: 8,  scale: 5
    t.decimal  "hsp_committees_percentage_nonfederal_candidate_support",            precision: 8,  scale: 5
    t.decimal  "hsp_committees_actual_federal_candidate_support",                   precision: 12, scale: 2
    t.decimal  "hsp_committees_actual_nonfederal_candidate_support",                precision: 12, scale: 2
    t.decimal  "hsp_committees_percentage_actual_federal",                          precision: 8,  scale: 5
    t.decimal  "actual_direct_candidate_support_federal",                           precision: 12, scale: 2
    t.decimal  "actual_direct_candidate_support_nonfederal",                        precision: 12, scale: 2
    t.decimal  "actual_direct_candidate_support_federal_percent",                   precision: 8,  scale: 5
    t.integer  "ballot_presidential"
    t.integer  "ballot_senate"
    t.integer  "ballot_house"
    t.integer  "subtotal_federal"
    t.integer  "ballot_governor"
    t.integer  "ballot_other_statewide"
    t.integer  "ballot_state_senate"
    t.integer  "ballot_state_representative"
    t.integer  "ballot_local_candidates"
    t.integer  "extra_nonfederal_point"
    t.integer  "subtotal"
    t.integer  "total_points"
    t.string   "fec_record_type",                                        limit: 1,                           default: "C"
  end

  add_index "fec_filing_h1", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h1", ["filer_committee_id_number"], name: "index_fec_filing_h1_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_h2", force: true do |t|
    t.integer  "fec_record_number",                                                          null: false, unsigned: true
    t.integer  "row_number",                                                                 null: false, unsigned: true
    t.integer  "lock_version",                                                 default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "transaction_id",            limit: 20
    t.string   "activity_event_name",       limit: 90
    t.string   "direct_fundraising",        limit: 1
    t.string   "direct_candidate_support",  limit: 1
    t.string   "ratio_code",                limit: 1
    t.decimal  "federal_percentage",                   precision: 8, scale: 5
    t.decimal  "nonfederal_percentage",                precision: 8, scale: 5
    t.string   "exempt_activity",           limit: 1
    t.string   "fec_record_type",           limit: 1,                          default: "C"
  end

  add_index "fec_filing_h2", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h2", ["filer_committee_id_number"], name: "index_fec_filing_h2_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_h3", force: true do |t|
    t.integer  "fec_record_number",                                                               null: false, unsigned: true
    t.integer  "row_number",                                                                      null: false, unsigned: true
    t.integer  "lock_version",                                                      default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "account_name",                  limit: 90
    t.string   "event_type",                    limit: 2
    t.string   "event_activity_name",           limit: 90
    t.date     "receipt_date"
    t.decimal  "total_amount_transferred",                 precision: 12, scale: 2
    t.decimal  "transferred_amount",                       precision: 12, scale: 2
    t.string   "fec_record_type",               limit: 1,                           default: "C"
  end

  add_index "fec_filing_h3", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h3", ["filer_committee_id_number"], name: "index_fec_filing_h3_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_h4", force: true do |t|
    t.integer  "fec_record_number",                                                                       null: false, unsigned: true
    t.integer  "row_number",                                                                              null: false, unsigned: true
    t.integer  "lock_version",                                                              default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                            limit: 8
    t.string   "filer_committee_id_number",            limit: 9
    t.string   "transaction_id_number",                limit: 20
    t.string   "back_reference_tran_id_number",        limit: 20
    t.string   "back_reference_sched_name",            limit: 8
    t.string   "entity_type",                          limit: 3
    t.string   "payee_organization_name",              limit: 200
    t.string   "payee_last_name",                      limit: 30
    t.string   "payee_first_name",                     limit: 20
    t.string   "payee_middle_name",                    limit: 20
    t.string   "payee_prefix",                         limit: 10
    t.string   "payee_suffix",                         limit: 10
    t.string   "payee_street_1",                       limit: 34
    t.string   "payee_street_2",                       limit: 34
    t.string   "payee_city",                           limit: 30
    t.string   "payee_state",                          limit: 2
    t.string   "payee_zip_code",                       limit: 9
    t.string   "account_identifier",                   limit: 90
    t.date     "expenditure_date"
    t.decimal  "total_amount",                                     precision: 12, scale: 2
    t.decimal  "federal_share",                                    precision: 12, scale: 2
    t.decimal  "nonfederal_share",                                 precision: 12, scale: 2
    t.decimal  "event_year_to_date",                               precision: 12, scale: 2
    t.string   "expenditure_purpose_description",      limit: 100
    t.string   "category_code",                        limit: 3
    t.string   "administrative_voter_drive_activity",  limit: 1
    t.string   "fundraising_activity",                 limit: 1
    t.string   "exempt_activity",                      limit: 1
    t.string   "generic_voter_drive_activity",         limit: 1
    t.string   "direct_candidate_support_activity",    limit: 1
    t.string   "public_communications_party_activity", limit: 1
    t.string   "memo_code",                            limit: 1
    t.string   "memo_text",                            limit: 100
    t.string   "expenditure_purpose_code",             limit: 3
    t.string   "payee_name",                           limit: 200
    t.string   "fec_committee_id_number",              limit: 9
    t.string   "fec_candidate_id_number",              limit: 9
    t.string   "candidate_name",                       limit: 200
    t.string   "candidate_office",                     limit: 1
    t.string   "candidate_state",                      limit: 2
    t.string   "candidate_district",                   limit: 2
    t.string   "conduit_name",                         limit: 200
    t.string   "conduit_street_1",                     limit: 34
    t.string   "conduit_street_2",                     limit: 34
    t.string   "conduit_city",                         limit: 30
    t.string   "conduit_state",                        limit: 2
    t.string   "conduit_zip_code",                     limit: 9
    t.string   "amended_cd",                           limit: 1
    t.string   "fec_record_type",                      limit: 1,                            default: "C"
  end

  add_index "fec_filing_h4", ["candidate_name"], name: "index_fec_filing_h4_on_candidate_name", using: :btree
  add_index "fec_filing_h4", ["conduit_name"], name: "index_fec_filing_h4_on_conduit_name", using: :btree
  add_index "fec_filing_h4", ["fec_candidate_id_number"], name: "index_fec_filing_h4_on_fec_candidate_id_number", using: :btree
  add_index "fec_filing_h4", ["fec_committee_id_number"], name: "index_fec_filing_h4_on_fec_committee_id_number", using: :btree
  add_index "fec_filing_h4", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h4", ["filer_committee_id_number"], name: "index_fec_filing_h4_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_h4", ["payee_name"], name: "index_fec_filing_h4_on_payee_name", using: :btree
  add_index "fec_filing_h4", ["payee_organization_name"], name: "index_fec_filing_h4_on_payee_organization_name", using: :btree

  create_table "fec_filing_h5", force: true do |t|
    t.integer  "fec_record_number",                                                           null: false, unsigned: true
    t.integer  "row_number",                                                                  null: false, unsigned: true
    t.integer  "lock_version",                                                  default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                 limit: 8
    t.string   "filer_committee_id_number", limit: 9
    t.string   "transaction_id",            limit: 20
    t.string   "account_name",              limit: 90
    t.date     "receipt_date"
    t.decimal  "total_amount_transferred",             precision: 12, scale: 2
    t.decimal  "voter_registration_amount",            precision: 12, scale: 2
    t.decimal  "voter_id_amount",                      precision: 12, scale: 2
    t.decimal  "gotv_amount",                          precision: 12, scale: 2
    t.decimal  "generic_campaign_amount",              precision: 12, scale: 2
    t.string   "fec_record_type",           limit: 1,                           default: "C"
  end

  add_index "fec_filing_h5", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h5", ["filer_committee_id_number"], name: "index_fec_filing_h5_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_h6", force: true do |t|
    t.integer  "fec_record_number",                                                                  null: false, unsigned: true
    t.integer  "row_number",                                                                         null: false, unsigned: true
    t.integer  "lock_version",                                                         default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                       limit: 8
    t.string   "filer_committee_id_number",       limit: 9
    t.string   "transaction_id_number",           limit: 20
    t.string   "back_reference_tran_id_number",   limit: 20
    t.string   "back_reference_sched_name",       limit: 8
    t.string   "entity_type",                     limit: 3
    t.string   "payee_organization_name",         limit: 200
    t.string   "payee_last_name",                 limit: 30
    t.string   "payee_first_name",                limit: 20
    t.string   "payee_middle_name",               limit: 20
    t.string   "payee_prefix",                    limit: 10
    t.string   "payee_suffix",                    limit: 10
    t.string   "payee_street_1",                  limit: 34
    t.string   "payee_street_2",                  limit: 34
    t.string   "payee_city",                      limit: 30
    t.string   "payee_state",                     limit: 2
    t.string   "payee_zip_code",                  limit: 9
    t.string   "account_identifier",              limit: 90
    t.date     "expenditure_date"
    t.decimal  "total_amount",                                precision: 12, scale: 2
    t.decimal  "federal_share",                               precision: 12, scale: 2
    t.decimal  "levin_share",                                 precision: 12, scale: 2
    t.decimal  "event_year_to_date",                          precision: 12, scale: 2
    t.string   "expenditure_purpose_description", limit: 100
    t.string   "category_code",                   limit: 3
    t.string   "voter_registration_activity",     limit: 1
    t.string   "gotv_activity",                   limit: 1
    t.string   "voter_id_activity",               limit: 1
    t.string   "generic_campaign_activity",       limit: 1
    t.string   "memo_code",                       limit: 1
    t.string   "memo_text",                       limit: 100
    t.string   "expenditure_purpose_code",        limit: 3
    t.string   "payee_name",                      limit: 200
    t.string   "fec_committee_id_number",         limit: 9
    t.string   "fec_candidate_id_number",         limit: 9
    t.string   "candidate_name",                  limit: 200
    t.string   "candidate_office",                limit: 1
    t.string   "candidate_state",                 limit: 2
    t.string   "candidate_district",              limit: 2
    t.string   "conduit_committee_id",            limit: 9
    t.string   "conduit_name",                    limit: 200
    t.string   "conduit_street_1",                limit: 34
    t.string   "conduit_street_2",                limit: 34
    t.string   "conduit_city",                    limit: 30
    t.string   "conduit_state",                   limit: 2
    t.string   "conduit_zip_code",                limit: 9
    t.string   "fec_record_type",                 limit: 1,                            default: "C"
  end

  add_index "fec_filing_h6", ["candidate_name"], name: "index_fec_filing_h6_on_candidate_name", using: :btree
  add_index "fec_filing_h6", ["conduit_name"], name: "index_fec_filing_h6_on_conduit_name", using: :btree
  add_index "fec_filing_h6", ["fec_candidate_id_number"], name: "index_fec_filing_h6_on_fec_candidate_id_number", using: :btree
  add_index "fec_filing_h6", ["fec_committee_id_number"], name: "index_fec_filing_h6_on_fec_committee_id_number", using: :btree
  add_index "fec_filing_h6", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_h6", ["filer_committee_id_number"], name: "index_fec_filing_h6_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_h6", ["payee_name"], name: "index_fec_filing_h6_on_payee_name", using: :btree
  add_index "fec_filing_h6", ["payee_organization_name"], name: "index_fec_filing_h6_on_payee_organization_name", using: :btree

  create_table "fec_filing_hdr", force: true do |t|
    t.integer  "fec_record_number",                           null: false, unsigned: true
    t.integer  "row_number",                                  null: false, unsigned: true
    t.integer  "lock_version",                  default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "record_type",       limit: 3
    t.string   "ef_type",           limit: 3
    t.string   "fec_version",       limit: 4
    t.string   "soft_name",         limit: 90
    t.string   "soft_ver",          limit: 16
    t.string   "report_id",         limit: 16
    t.integer  "report_number",                                            unsigned: true
    t.string   "comment",           limit: 200
    t.string   "name_delim",        limit: 1
    t.string   "fec_record_type",   limit: 1,   default: "C"
  end

  add_index "fec_filing_hdr", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_hdr", ["report_id"], name: "index_fec_filing_hdr_on_report_id", using: :btree

  create_table "fec_filing_sa", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id",                limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "back_reference_sched_name",     limit: 8
    t.string   "entity_type",                   limit: 3
    t.string   "contributor_organization_name", limit: 200
    t.string   "contributor_last_name",         limit: 30
    t.string   "contributor_first_name",        limit: 20
    t.string   "contributor_middle_name",       limit: 20
    t.string   "contributor_prefix",            limit: 10
    t.string   "contributor_suffix",            limit: 10
    t.string   "contributor_street_1",          limit: 34
    t.string   "contributor_street_2",          limit: 34
    t.string   "contributor_city",              limit: 30
    t.string   "contributor_state",             limit: 2
    t.string   "contributor_zip_code",          limit: 9
    t.string   "election_code",                 limit: 5
    t.string   "election_other_description",    limit: 20
    t.date     "contribution_date"
    t.decimal  "contribution_amount",                       precision: 12, scale: 2
    t.decimal  "contribution_aggregate",                    precision: 12, scale: 2
    t.string   "contribution_purpose_descrip",  limit: 100
    t.string   "contributor_employer",          limit: 38
    t.string   "contributor_occupation",        limit: 38
    t.string   "donor_committee_fec_id",        limit: 9
    t.string   "donor_committee_name",          limit: 200
    t.string   "donor_candidate_fec_id",        limit: 9
    t.string   "donor_candidate_last_name",     limit: 30
    t.string   "donor_candidate_first_name",    limit: 20
    t.string   "donor_candidate_middle_name",   limit: 20
    t.string   "donor_candidate_prefix",        limit: 10
    t.string   "donor_candidate_suffix",        limit: 10
    t.string   "donor_candidate_office",        limit: 1
    t.string   "donor_candidate_state",         limit: 2
    t.string   "donor_candidate_district",      limit: 2
    t.string   "conduit_name",                  limit: 200
    t.string   "conduit_street1",               limit: 34
    t.string   "conduit_street2",               limit: 34
    t.string   "conduit_city",                  limit: 30
    t.string   "conduit_state",                 limit: 2
    t.string   "conduit_zip_code",              limit: 9
    t.string   "memo_code",                     limit: 1
    t.string   "memo_text_description",         limit: 100
    t.string   "reference_code",                limit: 9
    t.string   "contribution_purpose_code",     limit: 3
    t.string   "increased_limit_code",          limit: 3
    t.string   "contributor_name",              limit: 200
    t.string   "donor_candidate_name",          limit: 200
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_sa", ["conduit_name"], name: "index_fec_filing_sa_on_conduit_name", using: :btree
  add_index "fec_filing_sa", ["contributor_name"], name: "index_fec_filing_sa_on_contributor_name", using: :btree
  add_index "fec_filing_sa", ["contributor_organization_name"], name: "index_fec_filing_sa_on_contributor_organization_name", using: :btree
  add_index "fec_filing_sa", ["donor_candidate_name"], name: "index_fec_filing_sa_on_donor_candidate_name", using: :btree
  add_index "fec_filing_sa", ["donor_committee_name"], name: "index_fec_filing_sa_on_donor_committee_name", using: :btree
  add_index "fec_filing_sa", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sa", ["filer_committee_id_number"], name: "index_fec_filing_sa_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_sb", force: true do |t|
    t.integer  "fec_record_number",                                                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                                                     limit: 8
    t.string   "filer_committee_id_number",                                     limit: 9
    t.string   "transaction_id_number",                                         limit: 20
    t.string   "back_reference_tran_id_number",                                 limit: 20
    t.string   "back_reference_sched_name",                                     limit: 8
    t.string   "entity_type",                                                   limit: 3
    t.string   "payee_organization_name",                                       limit: 200
    t.string   "payee_last_name",                                               limit: 30
    t.string   "payee_first_name",                                              limit: 20
    t.string   "payee_middle_name",                                             limit: 20
    t.string   "payee_prefix",                                                  limit: 10
    t.string   "payee_suffix",                                                  limit: 10
    t.string   "payee_street_1",                                                limit: 34
    t.string   "payee_street_2",                                                limit: 34
    t.string   "payee_city",                                                    limit: 30
    t.string   "payee_state",                                                   limit: 2
    t.string   "payee_zip_code",                                                limit: 9
    t.string   "election_code",                                                 limit: 5
    t.string   "election_other_description",                                    limit: 20
    t.date     "expenditure_date"
    t.decimal  "expenditure_amount",                                                        precision: 12, scale: 2
    t.decimal  "semi_annual_refunded_bundled_amt",                                          precision: 12, scale: 2
    t.string   "expenditure_purpose_descrip",                                   limit: 100
    t.string   "category_code",                                                 limit: 3
    t.string   "beneficiary_committee_fec_id",                                  limit: 9
    t.string   "beneficiary_committee_name",                                    limit: 200
    t.string   "beneficiary_candidate_fec_id",                                  limit: 9
    t.string   "beneficiary_candidate_last_name",                               limit: 30
    t.string   "beneficiary_candidate_first_name",                              limit: 20
    t.string   "beneficiary_candidate_middle_name",                             limit: 20
    t.string   "beneficiary_candidate_prefix",                                  limit: 10
    t.string   "beneficiary_candidate_suffix",                                  limit: 10
    t.string   "beneficiary_candidate_office",                                  limit: 1
    t.string   "beneficiary_candidate_state",                                   limit: 2
    t.string   "beneficiary_candidate_district",                                limit: 2
    t.string   "conduit_name",                                                  limit: 200
    t.string   "conduit_street_1",                                              limit: 34
    t.string   "conduit_street_2",                                              limit: 34
    t.string   "conduit_city",                                                  limit: 30
    t.string   "conduit_state",                                                 limit: 2
    t.string   "conduit_zip_code",                                              limit: 9
    t.string   "memo_code",                                                     limit: 1
    t.string   "memo_text_description",                                         limit: 100
    t.string   "reference_to_si_or_sl_system_code_that_identifies_the_account", limit: 9
    t.string   "expenditure_purpose_code",                                      limit: 3
    t.string   "refund_or_disposal_of_excess",                                  limit: 1
    t.date     "communication_date"
    t.string   "payee_name",                                                    limit: 200
    t.string   "beneficiary_candidate_name",                                    limit: 200
    t.string   "fec_record_type",                                               limit: 1,                            default: "C"
  end

  add_index "fec_filing_sb", ["beneficiary_candidate_name"], name: "index_fec_filing_sb_on_beneficiary_candidate_name", using: :btree
  add_index "fec_filing_sb", ["beneficiary_committee_name"], name: "index_fec_filing_sb_on_beneficiary_committee_name", using: :btree
  add_index "fec_filing_sb", ["conduit_name"], name: "index_fec_filing_sb_on_conduit_name", using: :btree
  add_index "fec_filing_sb", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sb", ["filer_committee_id_number"], name: "index_fec_filing_sb_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sb", ["payee_name"], name: "index_fec_filing_sb_on_payee_name", using: :btree
  add_index "fec_filing_sb", ["payee_organization_name"], name: "index_fec_filing_sb_on_payee_organization_name", using: :btree

  create_table "fec_filing_sc", force: true do |t|
    t.integer  "fec_record_number",                                                               null: false, unsigned: true
    t.integer  "row_number",                                                                      null: false, unsigned: true
    t.integer  "lock_version",                                                      default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                    limit: 8
    t.string   "filer_committee_id_number",    limit: 9
    t.string   "transaction_id_number",        limit: 20
    t.string   "receipt_line_number",          limit: 8
    t.string   "entity_type",                  limit: 3
    t.string   "lender_organization_name",     limit: 200
    t.string   "lender_last_name",             limit: 30
    t.string   "lender_first_name",            limit: 20
    t.string   "lender_middle_name",           limit: 20
    t.string   "lender_prefix",                limit: 10
    t.string   "lender_suffix",                limit: 10
    t.string   "lender_street_1",              limit: 34
    t.string   "lender_street_2",              limit: 34
    t.string   "lender_city",                  limit: 30
    t.string   "lender_state",                 limit: 2
    t.string   "lender_zip_code",              limit: 9
    t.string   "election_code",                limit: 5
    t.string   "election_other_description",   limit: 20
    t.decimal  "loan_amount_original",                     precision: 12, scale: 2
    t.decimal  "loan_payment_to_date",                     precision: 12, scale: 2
    t.decimal  "loan_balance",                             precision: 12, scale: 2
    t.integer  "loan_incurred_date_terms"
    t.string   "loan_due_date_terms",          limit: 15
    t.string   "loan_interest_rate_terms",     limit: 15
    t.string   "secured",                      limit: 1
    t.string   "personal_funds",               limit: 1
    t.string   "lender_committee_id_number",   limit: 9
    t.string   "lender_candidate_id_number",   limit: 9
    t.string   "lender_candidate_last_name",   limit: 30
    t.string   "lender_candidate_first_name",  limit: 20
    t.string   "lender_candidate_middle_name"
    t.string   "lender_candidate_prefix",      limit: 10
    t.string   "lender_candidate_suffix",      limit: 10
    t.string   "lender_candidate_office",      limit: 1
    t.string   "lender_candidate_state",       limit: 2
    t.string   "lender_candidate_district",    limit: 2
    t.string   "memo_code",                    limit: 1
    t.string   "memo_text_description",        limit: 100
    t.string   "lender_name",                  limit: 200
    t.string   "lender_candidate_name",        limit: 200
    t.string   "fec_record_type",              limit: 1,                            default: "C"
  end

  add_index "fec_filing_sc", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sc", ["filer_committee_id_number"], name: "index_fec_filing_sc_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sc", ["lender_candidate_id_number"], name: "index_fec_filing_sc_on_lender_candidate_id_number", using: :btree
  add_index "fec_filing_sc", ["lender_candidate_name"], name: "index_fec_filing_sc_on_lender_candidate_name", using: :btree
  add_index "fec_filing_sc", ["lender_committee_id_number"], name: "index_fec_filing_sc_on_lender_committee_id_number", using: :btree
  add_index "fec_filing_sc", ["lender_name"], name: "index_fec_filing_sc_on_lender_name", using: :btree
  add_index "fec_filing_sc", ["lender_organization_name"], name: "index_fec_filing_sc_on_lender_organization_name", using: :btree

  create_table "fec_filing_sc1", force: true do |t|
    t.integer  "fec_record_number",                                                                      null: false, unsigned: true
    t.integer  "row_number",                                                                             null: false, unsigned: true
    t.integer  "lock_version",                                                             default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                           limit: 8
    t.string   "filer_committee_id_number",           limit: 9
    t.string   "transaction_id_number",               limit: 20
    t.string   "back_reference_tran_id_number",       limit: 20
    t.string   "lender_organization_name",            limit: 200
    t.string   "lender_street_1",                     limit: 34
    t.string   "lender_street_2",                     limit: 34
    t.string   "lender_city",                         limit: 30
    t.string   "lender_state",                        limit: 2
    t.string   "lender_zip_code",                     limit: 9
    t.decimal  "loan_amount",                                     precision: 12, scale: 2
    t.string   "loan_interest_rate",                  limit: 15
    t.date     "loan_incurred_date"
    t.string   "loan_due_date",                       limit: 15
    t.string   "loan_restructured",                   limit: 1
    t.date     "loan_inccured_date_original"
    t.decimal  "credit_amount_this_draw",                         precision: 12, scale: 2
    t.decimal  "total_balance",                                   precision: 12, scale: 2
    t.string   "others_liable",                       limit: 1
    t.string   "collateral",                          limit: 1
    t.string   "description",                         limit: 100
    t.decimal  "collateral_value_amount",                         precision: 12, scale: 2
    t.string   "perfected_interest",                  limit: 1
    t.string   "future_income",                       limit: 1
    t.decimal  "estimated_value",                                 precision: 12, scale: 2
    t.date     "established_date"
    t.string   "account_location_name",               limit: 200
    t.string   "street_1",                            limit: 34
    t.string   "street_2",                            limit: 34
    t.string   "city",                                limit: 30
    t.string   "state",                               limit: 2
    t.string   "zip_code",                            limit: 9
    t.date     "deposit_acct_auth_date_presidential"
    t.string   "f_basis_of_loan_description"
    t.string   "treasurer_last_name",                 limit: 30
    t.string   "treasurer_first_name",                limit: 20
    t.string   "treasurer_middle_name",               limit: 20
    t.string   "treasurer_prefix",                    limit: 10
    t.string   "treasurer_suffix",                    limit: 10
    t.date     "date_signed"
    t.string   "authorized_last_name",                limit: 30
    t.string   "authorized_first_name",               limit: 20
    t.string   "authorized_middle_name",              limit: 20
    t.string   "authorized_prefix",                   limit: 10
    t.string   "authorized_suffix",                   limit: 10
    t.string   "authorized_title",                    limit: 20
    t.string   "entity_type",                         limit: 3
    t.string   "treasurer_name",                      limit: 200
    t.string   "authorized_name",                     limit: 200
    t.string   "fec_record_type",                     limit: 1,                            default: "C"
  end

  add_index "fec_filing_sc1", ["account_location_name"], name: "index_fec_filing_sc1_on_account_location_name", using: :btree
  add_index "fec_filing_sc1", ["authorized_name"], name: "index_fec_filing_sc1_on_authorized_name", using: :btree
  add_index "fec_filing_sc1", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sc1", ["filer_committee_id_number"], name: "index_fec_filing_sc1_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sc1", ["lender_organization_name"], name: "index_fec_filing_sc1_on_lender_organization_name", using: :btree
  add_index "fec_filing_sc1", ["treasurer_name"], name: "index_fec_filing_sc1_on_treasurer_name", using: :btree

  create_table "fec_filing_sc2", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id_number",         limit: 20
    t.string   "back_reference_tran_id_number", limit: 20
    t.string   "guarantor_last_name",           limit: 30
    t.string   "guarantor_first_name",          limit: 20
    t.string   "guarantor_middle_name",         limit: 20
    t.string   "guarantor_prefix",              limit: 10
    t.string   "guarantor_suffix",              limit: 10
    t.string   "guarantor_street_1",            limit: 34
    t.string   "guarantor_street_2",            limit: 34
    t.string   "guarantor_city",                limit: 30
    t.string   "guarantor_state",               limit: 2
    t.string   "guarantor_zip_code",            limit: 9
    t.string   "guarantor_employer",            limit: 38
    t.string   "guarantor_occupation",          limit: 38
    t.decimal  "guaranteed_amount",                         precision: 12, scale: 2
    t.string   "guarantor_name",                limit: 200
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_sc2", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sc2", ["filer_committee_id_number"], name: "index_fec_filing_sc2_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sc2", ["guarantor_name"], name: "index_fec_filing_sc2_on_guarantor_name", using: :btree

  create_table "fec_filing_sd", force: true do |t|
    t.integer  "fec_record_number",                                                                null: false, unsigned: true
    t.integer  "row_number",                                                                       null: false, unsigned: true
    t.integer  "lock_version",                                                       default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                     limit: 8
    t.string   "filer_committee_id_number",     limit: 9
    t.string   "transaction_id_number",         limit: 20
    t.string   "entity_type",                   limit: 3
    t.string   "creditor_organization_name",    limit: 200
    t.string   "creditor_last_name",            limit: 30
    t.string   "creditor_first_name",           limit: 20
    t.string   "creditor_middle_name",          limit: 20
    t.string   "creditor_prefix",               limit: 10
    t.string   "creditor_suffix",               limit: 10
    t.string   "creditor_street_1",             limit: 34
    t.string   "creditor_street_2",             limit: 34
    t.string   "creditor_city",                 limit: 30
    t.string   "creditor_state",                limit: 2
    t.string   "creditor_zip_code",             limit: 9
    t.string   "purpose_of_debt_or_obligation", limit: 100
    t.decimal  "beginning_balance_this_period",             precision: 12, scale: 2
    t.decimal  "incurred_amount_this_period",               precision: 12, scale: 2
    t.decimal  "payment_amount_this_period",                precision: 12, scale: 2
    t.decimal  "balance_at_close_this_period",              precision: 12, scale: 2
    t.string   "creditor_name",                 limit: 200
    t.string   "fec_committee_id_number",       limit: 9
    t.string   "fec_candidate_id_number",       limit: 9
    t.string   "candidate_name",                limit: 200
    t.string   "candidate_office",              limit: 1
    t.string   "candidate_state",               limit: 2
    t.string   "candidate_district",            limit: 2
    t.string   "conduit_name",                  limit: 200
    t.string   "conduit_street_1",              limit: 34
    t.string   "conduit_street_2",              limit: 34
    t.string   "conduit_city",                  limit: 30
    t.string   "conduit_state",                 limit: 2
    t.string   "conduit_zip_code",              limit: 9
    t.string   "fec_record_type",               limit: 1,                            default: "C"
  end

  add_index "fec_filing_sd", ["candidate_name"], name: "index_fec_filing_sd_on_candidate_name", using: :btree
  add_index "fec_filing_sd", ["conduit_name"], name: "index_fec_filing_sd_on_conduit_name", using: :btree
  add_index "fec_filing_sd", ["creditor_name"], name: "index_fec_filing_sd_on_creditor_name", using: :btree
  add_index "fec_filing_sd", ["creditor_organization_name"], name: "index_fec_filing_sd_on_creditor_organization_name", using: :btree
  add_index "fec_filing_sd", ["fec_candidate_id_number"], name: "index_fec_filing_sd_on_fec_candidate_id_number", using: :btree
  add_index "fec_filing_sd", ["fec_committee_id_number"], name: "index_fec_filing_sd_on_fec_committee_id_number", using: :btree
  add_index "fec_filing_sd", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sd", ["filer_committee_id_number"], name: "index_fec_filing_sd_on_filer_committee_id_number", using: :btree

  create_table "fec_filing_se", force: true do |t|
    t.integer  "fec_record_number",                                                                     null: false, unsigned: true
    t.integer  "row_number",                                                                            null: false, unsigned: true
    t.integer  "lock_version",                                                            default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                          limit: 8
    t.string   "filer_committee_id_number",          limit: 9
    t.string   "transaction_id_number",              limit: 20
    t.string   "back_reference_tran_id_number",      limit: 20
    t.string   "back_reference_sched_name",          limit: 8
    t.string   "entity_type",                        limit: 3
    t.string   "payee_organization_name",            limit: 200
    t.string   "payee_last_name",                    limit: 30
    t.string   "payee_first_name",                   limit: 20
    t.string   "payee_middle_name",                  limit: 20
    t.string   "payee_prefix",                       limit: 10
    t.string   "payee_suffix",                       limit: 10
    t.string   "payee_street_1",                     limit: 34
    t.string   "payee_street_2",                     limit: 34
    t.string   "payee_city",                         limit: 30
    t.string   "payee_state",                        limit: 2
    t.string   "payee_zip_code",                     limit: 9
    t.string   "election_code",                      limit: 5
    t.string   "election_other_description",         limit: 20
    t.date     "dissemination_date"
    t.decimal  "expenditure_amount",                             precision: 12, scale: 2
    t.date     "disbursement_date"
    t.decimal  "calendar_y_t_d_per_election_office",             precision: 12, scale: 2
    t.string   "expenditure_purpose_descrip",        limit: 100
    t.string   "category_code",                      limit: 3
    t.string   "payee_cmtte_fec_id_number",          limit: 9
    t.string   "support_oppose_code",                limit: 3
    t.string   "candidate_id_number",                limit: 9
    t.string   "candidate_last_name",                limit: 30
    t.string   "candidate_first_name",               limit: 20
    t.string   "candidate_middle_name",              limit: 20
    t.string   "candidate_prefix",                   limit: 10
    t.string   "candidate_suffix",                   limit: 10
    t.string   "candidate_office",                   limit: 1
    t.string   "candidate_district",                 limit: 2
    t.string   "candidate_state",                    limit: 2
    t.string   "completing_last_name",               limit: 30
    t.string   "completing_first_name",              limit: 20
    t.string   "completing_middle_name",             limit: 20
    t.string   "completing_prefix",                  limit: 10
    t.string   "completing_suffix",                  limit: 10
    t.date     "date_signed"
    t.string   "memo_code",                          limit: 1
    t.string   "memo_text_description",              limit: 100
    t.string   "expenditure_purpose_code",           limit: 3
    t.string   "payee_name",                         limit: 200
    t.string   "candidate_name",                     limit: 200
    t.string   "conduit_name",                       limit: 200
    t.string   "conduit_street_1",                   limit: 34
    t.string   "conduit_street_2",                   limit: 34
    t.string   "conduit_city",                       limit: 30
    t.string   "conduit_state",                      limit: 2
    t.string   "conduit_zip_code",                   limit: 9
    t.string   "ind_name_as_signed",                 limit: 200
    t.date     "date_notarized"
    t.date     "date_notary_commission_expires"
    t.string   "ind_name_notary",                    limit: 200
    t.string   "fec_record_type",                    limit: 1,                            default: "C"
  end

  add_index "fec_filing_se", ["candidate_id_number"], name: "index_fec_filing_se_on_candidate_id_number", using: :btree
  add_index "fec_filing_se", ["candidate_name"], name: "index_fec_filing_se_on_candidate_name", using: :btree
  add_index "fec_filing_se", ["conduit_name"], name: "index_fec_filing_se_on_conduit_name", using: :btree
  add_index "fec_filing_se", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_se", ["filer_committee_id_number"], name: "index_fec_filing_se_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_se", ["payee_cmtte_fec_id_number"], name: "index_fec_filing_se_on_payee_cmtte_fec_id_number", using: :btree
  add_index "fec_filing_se", ["payee_name"], name: "index_fec_filing_se_on_payee_name", using: :btree
  add_index "fec_filing_se", ["payee_organization_name"], name: "index_fec_filing_se_on_payee_organization_name", using: :btree

  create_table "fec_filing_sf", force: true do |t|
    t.integer  "fec_record_number",                                                                  null: false, unsigned: true
    t.integer  "row_number",                                                                         null: false, unsigned: true
    t.integer  "lock_version",                                                         default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                       limit: 8
    t.string   "filer_committee_id_number",       limit: 9
    t.string   "transaction_id_number",           limit: 20
    t.string   "back_reference_tran_id_number",   limit: 20
    t.string   "back_reference_sched_name",       limit: 8
    t.string   "coordinated_expenditures",        limit: 1
    t.string   "designating_committee_id_number", limit: 9
    t.string   "designating_committee_name",      limit: 200
    t.string   "subordinate_committee_id_number", limit: 9
    t.string   "subordinate_committee_name",      limit: 200
    t.string   "subordinate_street_1",            limit: 34
    t.string   "subordinate_street_2",            limit: 34
    t.string   "subordinate_city",                limit: 30
    t.string   "subordinate_state",               limit: 2
    t.string   "subordinate_zip_code",            limit: 9
    t.string   "entity_type",                     limit: 3
    t.string   "payee_organization_name",         limit: 200
    t.string   "payee_last_name",                 limit: 30
    t.string   "payee_first_name",                limit: 20
    t.string   "payee_middle_name",               limit: 20
    t.string   "payee_prefix",                    limit: 10
    t.string   "payee_suffix",                    limit: 10
    t.string   "payee_street_1",                  limit: 34
    t.string   "payee_street_2",                  limit: 34
    t.string   "payee_city",                      limit: 30
    t.string   "payee_state",                     limit: 2
    t.string   "payee_zip_code",                  limit: 9
    t.date     "expenditure_date"
    t.decimal  "expenditure_amount",                          precision: 12, scale: 2
    t.decimal  "aggregate_general_elec_expended",             precision: 12, scale: 2
    t.string   "expenditure_purpose_descrip",     limit: 100
    t.string   "category_code",                   limit: 3
    t.string   "payee_committee_id_number",       limit: 9
    t.string   "payee_candidate_id_number",       limit: 9
    t.string   "payee_candidate_last_name",       limit: 30
    t.string   "payee_candidate_first_name",      limit: 20
    t.string   "payee_candidate_middle_name",     limit: 20
    t.string   "payee_candidate_prefix",          limit: 10
    t.string   "payee_candidate_suffix",          limit: 10
    t.string   "payee_candidate_office",          limit: 1
    t.string   "payee_candidate_state",           limit: 2
    t.string   "payee_candidate_district",        limit: 2
    t.string   "memo_code",                       limit: 1
    t.string   "memo_text_description",           limit: 100
    t.string   "expenditure_purpose_code",        limit: 3
    t.string   "increased_limit",                 limit: 3
    t.string   "payee_name",                      limit: 200
    t.string   "payee_candidate_name",            limit: 200
    t.string   "conduit_name",                    limit: 200
    t.string   "conduit_street_1",                limit: 34
    t.string   "conduit_street_2",                limit: 34
    t.string   "conduit_city",                    limit: 30
    t.string   "conduit_state",                   limit: 2
    t.string   "conduit_zip_code",                limit: 9
    t.string   "fec_record_type",                 limit: 1,                            default: "C"
  end

  add_index "fec_filing_sf", ["conduit_name"], name: "index_fec_filing_sf_on_conduit_name", using: :btree
  add_index "fec_filing_sf", ["designating_committee_id_number"], name: "index_fec_filing_sf_on_designating_committee_id_number", using: :btree
  add_index "fec_filing_sf", ["designating_committee_name"], name: "index_fec_filing_sf_on_designating_committee_name", using: :btree
  add_index "fec_filing_sf", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sf", ["filer_committee_id_number"], name: "index_fec_filing_sf_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sf", ["payee_candidate_id_number"], name: "index_fec_filing_sf_on_payee_candidate_id_number", using: :btree
  add_index "fec_filing_sf", ["payee_candidate_name"], name: "index_fec_filing_sf_on_payee_candidate_name", using: :btree
  add_index "fec_filing_sf", ["payee_committee_id_number"], name: "index_fec_filing_sf_on_payee_committee_id_number", using: :btree
  add_index "fec_filing_sf", ["payee_name"], name: "index_fec_filing_sf_on_payee_name", using: :btree
  add_index "fec_filing_sf", ["payee_organization_name"], name: "index_fec_filing_sf_on_payee_organization_name", using: :btree
  add_index "fec_filing_sf", ["subordinate_committee_id_number"], name: "index_fec_filing_sf_on_subordinate_committee_id_number", using: :btree
  add_index "fec_filing_sf", ["subordinate_committee_name"], name: "index_fec_filing_sf_on_subordinate_committee_name", using: :btree

  create_table "fec_filing_sl", force: true do |t|
    t.integer  "fec_record_number",                                                                        null: false, unsigned: true
    t.integer  "row_number",                                                                               null: false, unsigned: true
    t.integer  "lock_version",                                                               default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                              limit: 8
    t.string   "filer_committee_id_number",              limit: 9
    t.string   "transaction_id_number",                  limit: 20
    t.string   "record_id_number",                       limit: 9
    t.string   "account_name",                           limit: 90
    t.date     "coverage_from_date"
    t.date     "coverage_through_date"
    t.decimal  "col_a_itemized_receipts_persons",                   precision: 12, scale: 2
    t.decimal  "col_a_unitemized_receipts_persons",                 precision: 12, scale: 2
    t.decimal  "col_a_total_receipts_persons",                      precision: 12, scale: 2
    t.decimal  "col_a_other_receipts",                              precision: 12, scale: 2
    t.decimal  "col_a_total_receipts",                              precision: 12, scale: 2
    t.decimal  "col_a_voter_registration_disbursements",            precision: 12, scale: 2
    t.decimal  "col_a_voter_id_disbursements",                      precision: 12, scale: 2
    t.decimal  "col_a_gotv_disbursements",                          precision: 12, scale: 2
    t.decimal  "col_a_generic_campaign_disbursements",              precision: 12, scale: 2
    t.decimal  "col_a_disbursements_subtotal",                      precision: 12, scale: 2
    t.decimal  "col_a_other_disbursements",                         precision: 12, scale: 2
    t.decimal  "col_a_total_disbursements",                         precision: 12, scale: 2
    t.decimal  "col_a_cash_on_hand_beginning_period",               precision: 12, scale: 2
    t.decimal  "col_a_receipts_period",                             precision: 12, scale: 2
    t.decimal  "col_a_subtotal_period",                             precision: 12, scale: 2
    t.decimal  "col_b_disbursements_period",                        precision: 12, scale: 2
    t.decimal  "col_b_cash_on_hand_close_of_period",                precision: 12, scale: 2
    t.decimal  "col_b_itemized_receipts_persons",                   precision: 12, scale: 2
    t.decimal  "col_b_unitemized_receipts_persons",                 precision: 12, scale: 2
    t.decimal  "col_b_total_receipts_persons",                      precision: 12, scale: 2
    t.decimal  "col_b_other_receipts",                              precision: 12, scale: 2
    t.decimal  "col_b_total_receipts",                              precision: 12, scale: 2
    t.decimal  "col_b_voter_registration_disbursements",            precision: 12, scale: 2
    t.decimal  "col_b_voter_id_disbursements",                      precision: 12, scale: 2
    t.decimal  "col_b_gotv_disbursements",                          precision: 12, scale: 2
    t.decimal  "col_b_generic_campaign_disbursements",              precision: 12, scale: 2
    t.decimal  "col_b_disbursements_subtotal",                      precision: 12, scale: 2
    t.decimal  "col_b_other_disbursements",                         precision: 12, scale: 2
    t.decimal  "col_b_total_disbursements",                         precision: 12, scale: 2
    t.decimal  "col_b_cash_on_hand_beginning_period",               precision: 12, scale: 2
    t.decimal  "col_b_receipts_period",                             precision: 12, scale: 2
    t.decimal  "col_b_subtotal_period",                             precision: 12, scale: 2
    t.string   "fec_record_type",                        limit: 1,                           default: "C"
  end

  add_index "fec_filing_sl", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_sl", ["filer_committee_id_number"], name: "index_fec_filing_sl_on_filer_committee_id_number", using: :btree
  add_index "fec_filing_sl", ["record_id_number"], name: "index_fec_filing_sl_on_record_id_number", using: :btree

  create_table "fec_filing_text", force: true do |t|
    t.integer  "fec_record_number",                                       null: false, unsigned: true
    t.integer  "row_number",                                              null: false, unsigned: true
    t.integer  "lock_version",                              default: 0,   null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",                      limit: 8
    t.string   "rec_type",                       limit: 4
    t.string   "filer_committee_id_number",      limit: 9
    t.string   "transaction_id_number",          limit: 20
    t.string   "back_reference_tran_id_number",  limit: 20
    t.string   "back_reference_sched_form_name", limit: 8
    t.text     "text"
    t.string   "fec_record_type",                limit: 1,  default: "C"
  end

  add_index "fec_filing_text", ["fec_record_type", "fec_record_number", "row_number"], name: "record_index", unique: true, using: :btree
  add_index "fec_filing_text", ["filer_committee_id_number"], name: "index_fec_filing_text_on_filer_committee_id_number", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider",                 null: false
    t.string   "uid",                      null: false
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.text     "description"
    t.string   "image"
    t.string   "phone"
    t.text     "urls"
    t.string   "token"
    t.string   "secret"
    t.text     "raw_info"
    t.integer  "lock_version", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "identities", ["email"], name: "index_identities_on_email", using: :btree
  add_index "identities", ["name"], name: "index_identities_on_name", using: :btree
  add_index "identities", ["nickname"], name: "index_identities_on_nickname", using: :btree
  add_index "identities", ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true, using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "initiative_support", force: true do |t|
    t.integer  "initiative_id",                 null: false
    t.integer  "committee_id",                  null: false
    t.boolean  "support"
    t.boolean  "primary",       default: false
    t.text     "statement"
    t.string   "url"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "initiatives", force: true do |t|
    t.string   "jurisdiction",                    null: false
    t.date     "election_date"
    t.string   "election_type",        limit: 15
    t.string   "status"
    t.string   "initiator_type",       limit: 30
    t.string   "initiative_type",      limit: 30
    t.boolean  "indirect"
    t.string   "initiative_name"
    t.string   "proposition_name"
    t.string   "title",                           null: false
    t.string   "informal_title"
    t.text     "short_summary"
    t.text     "summary"
    t.text     "analysis"
    t.text     "text"
    t.string   "wikipedia_url"
    t.string   "ballotpedia_url"
    t.date     "filing_date"
    t.date     "summary_date"
    t.date     "circulation_deadline"
    t.date     "full_check_deadline"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "initiatives", ["election_date"], name: "index_initiatives_on_election_date", using: :btree
  add_index "initiatives", ["election_type"], name: "index_initiatives_on_election_type", using: :btree
  add_index "initiatives", ["initiative_name"], name: "index_initiatives_on_initiative_name", using: :btree
  add_index "initiatives", ["jurisdiction"], name: "index_initiatives_on_jurisdiction", using: :btree
  add_index "initiatives", ["proposition_name"], name: "index_initiatives_on_proposition_name", using: :btree
  add_index "initiatives", ["status"], name: "index_initiatives_on_status", using: :btree
  add_index "initiatives", ["title"], name: "index_initiatives_on_title", using: :btree

  create_table "legal_identities", force: true do |t|
    t.boolean  "human",                   null: false
    t.date     "birthdate"
    t.integer  "irs_id"
    t.boolean  "govt_contractor"
    t.boolean  "us_citizen_or_greencard"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legal_identities", ["irs_id"], name: "index_legal_identities_on_irs_id", unique: true, using: :btree

  create_table "legal_name_usages", force: true do |t|
    t.integer  "legal_name_id",     null: false
    t.integer  "legal_identity_id", null: false
    t.date     "from"
    t.date     "to"
    t.string   "authority"
    t.datetime "confirmed"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legal_name_usages", ["legal_identity_id"], name: "index_legal_name_usages_on_legal_identity_id", using: :btree
  add_index "legal_name_usages", ["legal_name_id"], name: "index_legal_name_usages_on_legal_name_id", using: :btree

  create_table "legal_names", force: true do |t|
    t.string "full_name"
    t.string "name_prefix"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "name_suffix"
  end

  add_index "legal_names", ["full_name"], name: "index_legal_names_on_full_name", using: :btree
  add_index "legal_names", ["last_name", "first_name"], name: "index_legal_names_on_last_name_and_first_name", using: :btree

  create_table "links", force: true do |t|
    t.string   "url",                             null: false
    t.integer  "duplicate_of_id"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked",         default: false, null: false
  end

  add_index "links", ["url", "duplicate_of_id"], name: "index_links_on_url_and_duplicate_of_id", using: :btree
  add_index "links", ["url"], name: "index_links_on_url", unique: true, using: :btree

  create_table "ny_voters", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "name_suffix"
    t.string   "residence_house_number"
    t.string   "residence_fractional_number"
    t.string   "residence_apartment"
    t.string   "residence_pre_street_direction"
    t.string   "residence_street_name"
    t.string   "residence_post_street_direction"
    t.string   "residence_city"
    t.string   "residence_zip5"
    t.string   "residence_zip4"
    t.string   "mailing_address_1"
    t.string   "mailing_address_2"
    t.string   "mailing_address_3"
    t.string   "mailing_address_4"
    t.string   "dob"
    t.string   "gender"
    t.string   "enrollment"
    t.string   "other_party"
    t.integer  "county_code"
    t.integer  "election_district"
    t.integer  "legislative_district"
    t.string   "town_city"
    t.string   "ward"
    t.integer  "congressional_district"
    t.integer  "senate_district"
    t.integer  "assembly_district"
    t.string   "last_date_voted"
    t.string   "last_year_voted"
    t.string   "last_county_voted"
    t.string   "last_registered_address"
    t.string   "last_registered_name"
    t.string   "county_voter_registration_number"
    t.string   "application_date"
    t.string   "application_source"
    t.string   "id_required"
    t.string   "id_verification_met"
    t.string   "status"
    t.string   "reason"
    t.string   "inactive_date"
    t.string   "purged_date"
    t.string   "voter_id"
    t.text     "voter_history"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ny_voters", ["assembly_district"], name: "index_ny_voters_on_assembly_district", using: :btree
  add_index "ny_voters", ["congressional_district"], name: "index_ny_voters_on_congressional_district", using: :btree
  add_index "ny_voters", ["county_code"], name: "index_ny_voters_on_county_code", using: :btree
  add_index "ny_voters", ["county_voter_registration_number"], name: "index_ny_voters_on_county_voter_registration_number", using: :btree
  add_index "ny_voters", ["dob"], name: "index_ny_voters_on_dob", using: :btree
  add_index "ny_voters", ["election_district"], name: "index_ny_voters_on_election_district", using: :btree
  add_index "ny_voters", ["enrollment", "other_party"], name: "index_ny_voters_on_enrollment_and_other_party", using: :btree
  add_index "ny_voters", ["first_name"], name: "index_ny_voters_on_first_name", using: :btree
  add_index "ny_voters", ["last_name", "first_name"], name: "index_ny_voters_on_last_name_and_first_name", using: :btree
  add_index "ny_voters", ["legislative_district"], name: "index_ny_voters_on_legislative_district", using: :btree
  add_index "ny_voters", ["residence_city"], name: "index_ny_voters_on_residence_city", using: :btree
  add_index "ny_voters", ["residence_zip5", "residence_zip4"], name: "index_ny_voters_on_residence_zip5_and_residence_zip4", using: :btree
  add_index "ny_voters", ["senate_district"], name: "index_ny_voters_on_senate_district", using: :btree
  add_index "ny_voters", ["status", "reason"], name: "index_ny_voters_on_status_and_reason", using: :btree
  add_index "ny_voters", ["town_city"], name: "index_ny_voters_on_town_city", using: :btree
  add_index "ny_voters", ["voter_id"], name: "index_ny_voters_on_voter_id", unique: true, using: :btree
  add_index "ny_voters", ["ward"], name: "index_ny_voters_on_ward", using: :btree

  create_table "occupation_usages", force: true do |t|
    t.integer  "employee_id",   null: false
    t.integer  "employer_id"
    t.integer  "occupation_id", null: false
    t.date     "from"
    t.date     "to"
    t.datetime "confirmed"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "occupation_usages", ["employee_id", "employer_id"], name: "index_occupation_usages_on_employee_id_and_employer_id", using: :btree
  add_index "occupation_usages", ["employer_id", "occupation_id"], name: "index_occupation_usages_on_employer_id_and_occupation_id", using: :btree

  create_table "occupations", force: true do |t|
    t.string "name", null: false
  end

  add_index "occupations", ["name"], name: "index_occupations_on_name", using: :btree

  create_table "ofac_sdns", force: true do |t|
    t.text     "name"
    t.string   "sdn_type"
    t.string   "program"
    t.string   "title"
    t.string   "vessel_call_sign"
    t.string   "vessel_type"
    t.string   "vessel_tonnage"
    t.string   "gross_registered_tonnage"
    t.string   "vessel_flag"
    t.string   "vessel_owner"
    t.text     "remarks"
    t.text     "address"
    t.string   "city"
    t.string   "country"
    t.string   "address_remarks"
    t.string   "alternate_identity_type"
    t.text     "alternate_identity_name"
    t.string   "alternate_identity_remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ofac_sdns", ["sdn_type"], name: "index_ofac_sdns_on_sdn_type", using: :btree

  create_table "paypal_notifications", force: true do |t|
    t.integer  "transaction_id"
    t.boolean  "legit"
    t.boolean  "test"
    t.string   "pay_key"
    t.string   "status",         limit: 20
    t.text     "details_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paypal_notifications", ["legit"], name: "index_paypal_notifications_on_legit", using: :btree
  add_index "paypal_notifications", ["pay_key"], name: "index_paypal_notifications_on_pay_key", using: :btree
  add_index "paypal_notifications", ["status"], name: "index_paypal_notifications_on_status", using: :btree
  add_index "paypal_notifications", ["transaction_id"], name: "index_paypal_notifications_on_transaction_id", using: :btree

  create_table "paypal_subtransactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "transaction_id",                                   null: false
    t.string   "paypal_transaction_id"
    t.string   "sender_transaction_id"
    t.string   "receiver"
    t.integer  "amount_cents",                                     null: false
    t.string   "currency",              limit: 3,  default: "USD", null: false
    t.string   "status",                limit: 20
    t.string   "sender_status",         limit: 20
    t.integer  "refunded_amount_cents"
    t.boolean  "pending_refund"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paypal_subtransactions", ["currency", "amount_cents"], name: "index_paypal_subtransactions_on_currency_and_amount_cents", using: :btree
  add_index "paypal_subtransactions", ["paypal_transaction_id"], name: "index_paypal_subtransactions_on_paypal_transaction_id", using: :btree
  add_index "paypal_subtransactions", ["pending_refund"], name: "index_paypal_subtransactions_on_pending_refund", using: :btree
  add_index "paypal_subtransactions", ["receiver"], name: "index_paypal_subtransactions_on_receiver", using: :btree
  add_index "paypal_subtransactions", ["sender_status"], name: "index_paypal_subtransactions_on_sender_status", using: :btree
  add_index "paypal_subtransactions", ["sender_transaction_id"], name: "index_paypal_subtransactions_on_sender_transaction_id", using: :btree
  add_index "paypal_subtransactions", ["status"], name: "index_paypal_subtransactions_on_status", using: :btree
  add_index "paypal_subtransactions", ["transaction_id"], name: "index_paypal_subtransactions_on_transaction_id", using: :btree
  add_index "paypal_subtransactions", ["user_id"], name: "index_paypal_subtransactions_on_user_id", using: :btree

  create_table "paypal_transaction_notifications", force: true do |t|
    t.integer  "subtransaction_id"
    t.boolean  "legit"
    t.boolean  "test"
    t.string   "paypal_transaction_id",            null: false
    t.string   "status",                limit: 20
    t.text     "details_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paypal_transaction_notifications", ["legit"], name: "index_paypal_transaction_notifications_on_legit", using: :btree
  add_index "paypal_transaction_notifications", ["paypal_transaction_id"], name: "index_paypal_transaction_notifications_on_paypal_transaction_id", using: :btree
  add_index "paypal_transaction_notifications", ["status"], name: "index_paypal_transaction_notifications_on_status", using: :btree
  add_index "paypal_transaction_notifications", ["subtransaction_id"], name: "index_paypal_transaction_notifications_on_subtransaction_id", using: :btree

  create_table "paypal_transactions", force: true do |t|
    t.integer  "user_id"
    t.string   "source"
    t.string   "pay_key"
    t.integer  "amount_cents",                              null: false
    t.string   "currency",       limit: 3,  default: "USD", null: false
    t.string   "status",         limit: 20
    t.text     "details_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "correlation_id"
    t.string   "memo"
  end

  add_index "paypal_transactions", ["correlation_id"], name: "index_paypal_transactions_on_correlation_id", using: :btree
  add_index "paypal_transactions", ["currency", "amount_cents"], name: "index_paypal_transactions_on_currency_and_amount_cents", using: :btree
  add_index "paypal_transactions", ["source"], name: "index_paypal_transactions_on_source", using: :btree
  add_index "paypal_transactions", ["status"], name: "index_paypal_transactions_on_status", using: :btree
  add_index "paypal_transactions", ["user_id"], name: "index_paypal_transactions_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "handle",              null: false
    t.string   "handle_lowercase",    null: false
    t.string   "name",                null: false
    t.text     "bio"
    t.string   "type",                null: false
    t.integer  "legal_identity_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "avatar_meta"
    t.string   "avatar_fingerprint"
  end

  add_index "profiles", ["handle_lowercase"], name: "index_profiles_on_handle_lowercase", unique: true, using: :btree
  add_index "profiles", ["legal_identity_id"], name: "index_profiles_on_legal_identity_id", using: :btree
  add_index "profiles", ["name"], name: "index_profiles_on_name", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "search_results", force: true do |t|
    t.integer  "search_id"
    t.integer  "result_id"
    t.string   "result_type"
    t.datetime "created_at"
  end

  add_index "search_results", ["search_id", "result_type", "result_id"], name: "index_search_results_on_search_id_and_result_type_and_result_id", unique: true, using: :btree

  create_table "searches", force: true do |t|
    t.string   "term",                                 null: false
    t.string   "source",                               null: false
    t.string   "status",           default: "created", null: false
    t.integer  "update_frequency"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["source", "term"], name: "index_searches_on_source_and_term", unique: true, using: :btree
  add_index "searches", ["status"], name: "index_searches_on_status", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id",               null: false
    t.text     "data"
    t.integer  "lock_version", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "ssn_death_records", force: true do |t|
    t.string  "change_type",        limit: 1
    t.integer "ssn"
    t.string  "last_name",          limit: 20
    t.string  "name_suffix",        limit: 4
    t.string  "first_name",         limit: 15
    t.string  "middle_name",        limit: 15
    t.string  "verified",           limit: 1
    t.date    "death_date"
    t.date    "birth_date"
    t.boolean "death_date_noday"
    t.boolean "death_date_badleap"
    t.boolean "birth_date_noday"
    t.boolean "birth_date_badleap"
    t.integer "age_in_days"
  end

  add_index "ssn_death_records", ["birth_date", "death_date"], name: "index_ssn_death_records_on_birth_date_and_death_date", using: :btree
  add_index "ssn_death_records", ["death_date"], name: "index_ssn_death_records_on_death_date", using: :btree
  add_index "ssn_death_records", ["first_name"], name: "index_ssn_death_records_on_first_name", using: :btree
  add_index "ssn_death_records", ["last_name", "first_name"], name: "index_ssn_death_records_on_last_name_and_first_name", using: :btree
  add_index "ssn_death_records", ["ssn", "change_type"], name: "index_ssn_death_records_on_ssn_and_change_type", unique: true, using: :btree

  create_table "ssn_high_group_codes", force: true do |t|
    t.date     "as_of"
    t.string   "area"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ssn_high_group_codes", ["area", "as_of"], name: "idx_area_as_of", using: :btree
  add_index "ssn_high_group_codes", ["area"], name: "idx_area", using: :btree

  create_table "states", force: true do |t|
    t.string "abbreviation", limit: 2
    t.string "name",                                             null: false
    t.string "country",                default: "United States", null: false
  end

  add_index "states", ["country", "abbreviation"], name: "index_states_on_country_and_abbreviation", unique: true, using: :btree
  add_index "states", ["country", "name"], name: "index_states_on_country_and_name", unique: true, using: :btree

  create_table "stripe_accounts", force: true do |t|
    t.string  "stripe_id",            null: false
    t.boolean "charge_enabled",       null: false
    t.string  "currencies_enabled",   null: false
    t.boolean "details_submitted",    null: false
    t.boolean "transfer_enabled",     null: false
    t.string  "email",                null: false
    t.string  "statement_descriptor"
  end

  create_table "stripe_bank_accounts", force: true do |t|
    t.string  "stripe_id",             null: false
    t.string  "bank_name"
    t.string  "country",     limit: 2
    t.string  "last4"
    t.string  "fingerprint"
    t.boolean "validated"
  end

  create_table "stripe_cards", force: true do |t|
    t.integer  "exp_month",           limit: 1,  null: false
    t.integer  "exp_year",            limit: 2,  null: false
    t.string   "fingerprint",                    null: false
    t.string   "last4",               limit: 4,  null: false
    t.string   "type",                limit: 20, null: false
    t.string   "address_city"
    t.string   "address_country"
    t.string   "address_line1"
    t.string   "adress_line2"
    t.string   "address_state"
    t.string   "address_zip"
    t.boolean  "address_line1_check"
    t.boolean  "address_zip_check"
    t.boolean  "cvc_check"
    t.string   "country",             limit: 2
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_charges", force: true do |t|
    t.string   "stripe_id"
    t.boolean  "test"
    t.integer  "amount"
    t.boolean  "captured"
    t.integer  "stripe_card_id"
    t.datetime "stripe_created_at"
    t.string   "currency",           default: "usd"
    t.integer  "fee_amount"
    t.integer  "stripe_fee_id"
    t.boolean  "paid"
    t.boolean  "refunded"
    t.integer  "amount_refunded"
    t.integer  "stripe_customer_id"
    t.string   "description"
    t.string   "failure_code"
    t.string   "failure_message"
    t.integer  "stripe_invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_coupons", force: true do |t|
    t.string   "stripe_id",                                    null: false
    t.boolean  "test",                                         null: false
    t.string   "duration",                                     null: false
    t.integer  "amount_off"
    t.string   "currency",           limit: 3, default: "usd"
    t.integer  "duration_in_months"
    t.integer  "max_redemptions"
    t.integer  "percent_off",        limit: 1
    t.datetime "redeem_by"
    t.integer  "times_redeemed",               default: 0,     null: false
  end

  create_table "stripe_customers", force: true do |t|
    t.string   "stripe_id",                              null: false
    t.boolean  "test",                                   null: false
    t.datetime "stripe_created_at",                      null: false
    t.integer  "account_balance",        default: 0,     null: false
    t.integer  "stripe_card_id",                         null: false
    t.boolean  "delinquent",             default: false, null: false
    t.string   "description"
    t.integer  "stripe_discount_id"
    t.string   "email"
    t.integer  "stripe_subscription_id"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_discounts", force: true do |t|
    t.integer  "stripe_coupon_id",   null: false
    t.integer  "stripe_customer_id", null: false
    t.datetime "start",              null: false
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_disputes", force: true do |t|
    t.boolean  "test",                                         null: false
    t.integer  "amount",                                       null: false
    t.integer  "stripe_charge_id",                             null: false
    t.datetime "stripe_created_at",                            null: false
    t.string   "currency",          limit: 3,  default: "usd", null: false
    t.string   "reason",            limit: 25,                 null: false
    t.string   "status",            limit: 15,                 null: false
    t.text     "evidence"
    t.datetime "evidence_due_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_events", force: true do |t|
    t.string   "stripe_id",                       null: false
    t.boolean  "test",                            null: false
    t.datetime "stripe_created_at",               null: false
    t.integer  "pending_webhooks",    default: 0, null: false
    t.string   "type"
    t.string   "request"
    t.text     "object"
    t.text     "previous_attributes"
  end

  create_table "stripe_fees", force: true do |t|
    t.integer  "amount",                                    null: false
    t.string   "currency",        limit: 3, default: "usd", null: false
    t.string   "type",                                      null: false
    t.integer  "amount_refunded"
    t.string   "application"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_invoice_lines", force: true do |t|
    t.integer  "stripe_invoice_id_id"
    t.integer  "stripe_customer_id_id",                            null: false
    t.string   "stripe_id"
    t.boolean  "test",                                             null: false
    t.integer  "amount",                                           null: false
    t.string   "currency",                         default: "usd", null: false
    t.string   "type",                  limit: 15
    t.string   "description"
    t.integer  "stripe_plan_id"
    t.integer  "quantity"
    t.datetime "period_start"
    t.datetime "period_end"
    t.boolean  "proration"
  end

  create_table "stripe_invoices", force: true do |t|
    t.string   "stripe_id",                                      null: false
    t.boolean  "test",                                           null: false
    t.integer  "amount_due",                                     null: false
    t.integer  "attempt_count",                                  null: false
    t.boolean  "attempted",                      default: false, null: false
    t.boolean  "closed",                         default: false, null: false
    t.string   "currency",             limit: 3, default: "usd", null: false
    t.integer  "stripe_customer_id"
    t.datetime "date"
    t.boolean  "paid",                           default: false, null: false
    t.datetime "period_end",                                     null: false
    t.datetime "period_start",                                   null: false
    t.integer  "starting_balance",                               null: false
    t.integer  "subtotal",                                       null: false
    t.integer  "total",                                          null: false
    t.integer  "stripe_charge_id"
    t.integer  "stripe_discount_id"
    t.integer  "ending_balance"
    t.datetime "next_payment_attempt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_plans", force: true do |t|
    t.string   "stripe_id",                                   null: false
    t.boolean  "test",                                        null: false
    t.integer  "amount",                                      null: false
    t.string   "currency",          limit: 3, default: "usd", null: false
    t.string   "interval",          limit: 5,                 null: false
    t.integer  "interval_count",              default: 1,     null: false
    t.string   "name",                                        null: false
    t.integer  "trial_period_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_recipients", force: true do |t|
    t.string   "stripe_id",                         null: false
    t.boolean  "test",                              null: false
    t.datetime "stripe_created_at"
    t.string   "type",                   limit: 15
    t.integer  "stripe_bank_account_id"
    t.string   "description"
    t.string   "email"
    t.string   "name"
  end

  create_table "stripe_subscriptions", force: true do |t|
    t.boolean  "cancel_at_period_end",            default: false, null: false
    t.integer  "stripe_customer_id",                              null: false
    t.integer  "stripe_plan_id",                                  null: false
    t.integer  "quantity",                        default: 1,     null: false
    t.datetime "start",                                           null: false
    t.string   "status",               limit: 10,                 null: false
    t.datetime "canceled_at"
    t.datetime "current_period_end",                              null: false
    t.datetime "current_period_start",                            null: false
    t.datetime "ended_at"
    t.datetime "trial_end"
    t.datetime "trial_start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stripe_transfers", force: true do |t|
    t.string   "stripe_id",                                       null: false
    t.boolean  "test",                                            null: false
    t.integer  "amount",                                          null: false
    t.string   "currency",             limit: 3,  default: "usd", null: false
    t.datetime "date",                                            null: false
    t.integer  "fee",                                             null: false
    t.string   "status",               limit: 10,                 null: false
    t.string   "description"
    t.integer  "stripe_recipient_id"
    t.string   "statement_descriptor"
  end

  create_table "tweet_links", force: true do |t|
    t.integer "tweet_id", null: false
    t.integer "link_id",  null: false
  end

  add_index "tweet_links", ["link_id", "tweet_id"], name: "index_tweet_links_on_link_id_and_tweet_id", using: :btree
  add_index "tweet_links", ["tweet_id", "link_id"], name: "index_tweet_links_on_tweet_id_and_link_id", unique: true, using: :btree

  create_table "tweets", force: true do |t|
    t.integer  "twitter_id",   limit: 8,                     null: false
    t.string   "text",                                       null: false
    t.string   "user",                                       null: false
    t.integer  "favorited",              default: 0
    t.integer  "retweeted",              default: 0
    t.text     "raw",                                        null: false
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                 default: "created"
  end

  add_index "tweets", ["favorited", "retweeted"], name: "index_tweets_on_favorited_and_retweeted", using: :btree
  add_index "tweets", ["status"], name: "index_tweets_on_status", using: :btree
  add_index "tweets", ["twitter_id"], name: "index_tweets_on_twitter_id", unique: true, using: :btree
  add_index "tweets", ["user"], name: "index_tweets_on_user", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "name",                                null: false
    t.integer  "lock_version",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unconfirmed_email"], name: "index_users_on_unconfirmed_email", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.string   "ip"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "versions", ["ip"], name: "index_versions_on_ip", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["whodunnit"], name: "index_versions_on_whodunnit", using: :btree

end
