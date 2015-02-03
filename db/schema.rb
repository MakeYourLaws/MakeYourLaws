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

ActiveRecord::Schema.define(version: 20140930200004) do

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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "status",                 default: "created"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                null: false
    t.integer  "lock_version",           default: 0
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
