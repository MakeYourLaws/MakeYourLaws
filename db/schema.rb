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

ActiveRecord::Schema.define(:version => 20120618065618) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "fec_candidates", :force => true do |t|
    t.string   "fec_id",                       :limit => 9,                 :null => false
    t.string   "name",                         :limit => 38,                :null => false
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
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
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
    t.string   "encrypted_password",     :default => "",  :null => false
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

end
