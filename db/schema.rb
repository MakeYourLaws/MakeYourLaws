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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120917014000) do

  create_table "fec_candidates", :force => true do |t|
    t.string   "fec_id",                       :limit => 9,                  :null => false
    t.string   "name",                         :limit => 38, :default => ""
    t.string   "party",                        :limit => 3
    t.string   "party_2",                      :limit => 3
    t.string   "incumbent_challenger",         :limit => 1
    t.string   "status",                       :limit => 1
    t.string   "street_1",                     :limit => 34
    t.string   "street_2",                     :limit => 34
    t.string   "city",                         :limit => 18
    t.string   "state",                        :limit => 2
    t.string   "zip",                          :limit => 5
    t.string   "principal_campaign_committee", :limit => 9
    t.string   "year",                         :limit => 2
    t.string   "district",                     :limit => 2
    t.integer  "last_update_year"
    t.integer  "lock_version",                               :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "fec_candidates", ["district"], :name => "index_fec_candidates_on_district"
  add_index "fec_candidates", ["fec_id"], :name => "index_fec_candidates_on_fec_id", :unique => true
  add_index "fec_candidates", ["incumbent_challenger"], :name => "index_fec_candidates_on_incumbent_challenger"
  add_index "fec_candidates", ["name"], :name => "index_fec_candidates_on_name"
  add_index "fec_candidates", ["party"], :name => "index_fec_candidates_on_party"
  add_index "fec_candidates", ["party_2"], :name => "index_fec_candidates_on_party_2"
  add_index "fec_candidates", ["principal_campaign_committee"], :name => "index_fec_candidates_on_principal_campaign_committee"
  add_index "fec_candidates", ["state", "city"], :name => "index_fec_candidates_on_state_and_city"
  add_index "fec_candidates", ["status"], :name => "index_fec_candidates_on_status"
  add_index "fec_candidates", ["updated_at"], :name => "index_fec_candidates_on_updated_at"
  add_index "fec_candidates", ["year"], :name => "index_fec_candidates_on_year"

  create_table "fec_committees", :force => true do |t|
    t.string   "fec_id",                      :limit => 9,                 :null => false
    t.string   "name",                        :limit => 90,                :null => false
    t.string   "treasurer_name",              :limit => 38
    t.string   "street_1",                    :limit => 34
    t.string   "street_2",                    :limit => 34
    t.string   "city",                        :limit => 18
    t.string   "state",                       :limit => 2
    t.string   "zip",                         :limit => 5
    t.string   "designation",                 :limit => 1
    t.string   "type",                        :limit => 1
    t.string   "party",                       :limit => 3
    t.string   "filing_frequency",            :limit => 1
    t.string   "interest_group_category",     :limit => 1
    t.string   "connected_organization_name", :limit => 38
    t.string   "candidate_id",                :limit => 9
    t.integer  "last_update_year"
    t.integer  "lock_version",                              :default => 0
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "fec_committees", ["candidate_id"], :name => "index_fec_committees_on_candidate_id"
  add_index "fec_committees", ["connected_organization_name"], :name => "index_fec_committees_on_connected_organization_name"
  add_index "fec_committees", ["designation"], :name => "index_fec_committees_on_designation"
  add_index "fec_committees", ["fec_id"], :name => "index_fec_committees_on_fec_id", :unique => true
  add_index "fec_committees", ["interest_group_category"], :name => "index_fec_committees_on_interest_group_category"
  add_index "fec_committees", ["name"], :name => "index_fec_committees_on_name"
  add_index "fec_committees", ["party"], :name => "index_fec_committees_on_party"
  add_index "fec_committees", ["state", "city"], :name => "index_fec_committees_on_state_and_city"
  add_index "fec_committees", ["treasurer_name"], :name => "index_fec_committees_on_treasurer_name"
  add_index "fec_committees", ["updated_at"], :name => "index_fec_committees_on_updated_at"

  create_table "identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider",                    :null => false
    t.string   "uid",                         :null => false
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
    t.integer  "lock_version", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "url"
  end

  add_index "identities", ["email"], :name => "index_identities_on_email"
  add_index "identities", ["name"], :name => "index_identities_on_name"
  add_index "identities", ["nickname"], :name => "index_identities_on_nickname"
  add_index "identities", ["provider", "uid"], :name => "index_identities_on_provider_and_uid", :unique => true
  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "names", :force => true do |t|
    t.integer  "legal_identity_id"
    t.string   "full_name"
    t.string   "name_prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "name_suffix"
    t.date     "last_used"
    t.integer  "lock_version"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ny_voters", :force => true do |t|
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
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "ny_voters", ["assembly_district"], :name => "index_ny_voters_on_assembly_district"
  add_index "ny_voters", ["congressional_district"], :name => "index_ny_voters_on_congressional_district"
  add_index "ny_voters", ["county_code"], :name => "index_ny_voters_on_county_code"
  add_index "ny_voters", ["county_voter_registration_number"], :name => "index_ny_voters_on_county_voter_registration_number"
  add_index "ny_voters", ["dob"], :name => "index_ny_voters_on_dob"
  add_index "ny_voters", ["election_district"], :name => "index_ny_voters_on_election_district"
  add_index "ny_voters", ["enrollment", "other_party"], :name => "index_ny_voters_on_enrollment_and_other_party"
  add_index "ny_voters", ["first_name"], :name => "index_ny_voters_on_first_name"
  add_index "ny_voters", ["last_name", "first_name"], :name => "index_ny_voters_on_last_name_and_first_name"
  add_index "ny_voters", ["legislative_district"], :name => "index_ny_voters_on_legislative_district"
  add_index "ny_voters", ["residence_city"], :name => "index_ny_voters_on_residence_city"
  add_index "ny_voters", ["residence_zip5", "residence_zip4"], :name => "index_ny_voters_on_residence_zip5_and_residence_zip4"
  add_index "ny_voters", ["senate_district"], :name => "index_ny_voters_on_senate_district"
  add_index "ny_voters", ["status", "reason"], :name => "index_ny_voters_on_status_and_reason"
  add_index "ny_voters", ["town_city"], :name => "index_ny_voters_on_town_city"
  add_index "ny_voters", ["voter_id"], :name => "index_ny_voters_on_voter_id", :unique => true
  add_index "ny_voters", ["ward"], :name => "index_ny_voters_on_ward"

  create_table "paypal_notifications", :force => true do |t|
    t.integer  "transaction_id"
    t.boolean  "legit"
    t.boolean  "test"
    t.string   "pay_key"
    t.string   "status",         :limit => 20
    t.text     "details_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paypal_notifications", ["legit"], :name => "index_paypal_notifications_on_legit"
  add_index "paypal_notifications", ["pay_key"], :name => "index_paypal_notifications_on_pay_key"
  add_index "paypal_notifications", ["status"], :name => "index_paypal_notifications_on_status"
  add_index "paypal_notifications", ["transaction_id"], :name => "index_paypal_notifications_on_transaction_id"

  create_table "paypal_subtransactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "transaction_id",                                         :null => false
    t.string   "paypal_transaction_id"
    t.string   "sender_transaction_id"
    t.string   "receiver"
    t.integer  "amount_cents",                                           :null => false
    t.string   "currency",              :limit => 3,  :default => "USD", :null => false
    t.string   "status",                :limit => 20
    t.string   "sender_status",         :limit => 20
    t.integer  "refunded_amount_cents"
    t.boolean  "pending_refund"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "paypal_subtransactions", ["currency", "amount_cents"], :name => "index_paypal_subtransactions_on_currency_and_amount_cents"
  add_index "paypal_subtransactions", ["paypal_transaction_id"], :name => "index_paypal_subtransactions_on_paypal_transaction_id"
  add_index "paypal_subtransactions", ["pending_refund"], :name => "index_paypal_subtransactions_on_pending_refund"
  add_index "paypal_subtransactions", ["receiver"], :name => "index_paypal_subtransactions_on_receiver"
  add_index "paypal_subtransactions", ["sender_status"], :name => "index_paypal_subtransactions_on_sender_status"
  add_index "paypal_subtransactions", ["sender_transaction_id"], :name => "index_paypal_subtransactions_on_sender_transaction_id"
  add_index "paypal_subtransactions", ["status"], :name => "index_paypal_subtransactions_on_status"
  add_index "paypal_subtransactions", ["transaction_id"], :name => "index_paypal_subtransactions_on_transaction_id"
  add_index "paypal_subtransactions", ["user_id"], :name => "index_paypal_subtransactions_on_user_id"

  create_table "paypal_transactions", :force => true do |t|
    t.integer  "user_id"
    t.string   "source"
    t.string   "pay_key"
    t.integer  "amount_cents",                                    :null => false
    t.string   "currency",       :limit => 3,  :default => "USD", :null => false
    t.string   "status",         :limit => 20
    t.text     "details_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "correlation_id"
    t.string   "memo"
  end

  add_index "paypal_transactions", ["correlation_id"], :name => "index_paypal_transactions_on_correlation_id"
  add_index "paypal_transactions", ["currency", "amount_cents"], :name => "index_paypal_transactions_on_currency_and_amount"
  add_index "paypal_transactions", ["source"], :name => "index_paypal_transactions_on_source"
  add_index "paypal_transactions", ["status"], :name => "index_paypal_transactions_on_status"
  add_index "paypal_transactions", ["user_id"], :name => "index_paypal_transactions_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id",                  :null => false
    t.text     "data"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",  :null => false
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "name",                                    :null => false
    t.string   "login",                                   :null => false
    t.integer  "lock_version",           :default => 0
    t.string   "gauth_secret"
    t.string   "gauth_enabled",          :default => "f"
    t.string   "gauth_tmp"
    t.datetime "gauth_tmp_datetime"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["gauth_tmp"], :name => "index_users_on_gauth_tmp"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unconfirmed_email"], :name => "index_users_on_unconfirmed_email", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.string   "ip"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "versions", ["ip"], :name => "index_versions_on_ip"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["whodunnit"], :name => "index_versions_on_whodunnit"

end
