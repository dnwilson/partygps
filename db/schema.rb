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

ActiveRecord::Schema.define(version: 20150319210756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"
  enable_extension "unaccent"

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "location_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "photo"
    t.datetime "start_dt"
    t.datetime "end_dt"
    t.text     "description"
    t.string   "listed_day"
    t.string   "listed_month"
    t.string   "listed_type"
    t.decimal  "adm",          precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["id", "category_id"], name: "index_events_on_id_and_category_id", using: :btree
  add_index "events", ["id", "location_id", "category_id"], name: "index_events_on_id_and_location_id_and_category_id", using: :btree
  add_index "events", ["id", "location_id"], name: "index_events_on_id_and_location_id", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city_town"
    t.string   "state_parish"
    t.string   "zipcode"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "locations", ["id", "longitude", "latitude"], name: "index_locations_on_id_and_longitude_and_latitude", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city_town"
    t.string   "state_parish"
    t.string   "zipcode"
    t.string   "country"
    t.boolean  "primary_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.date     "dob"
    t.string   "address"
    t.string   "address2"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "country"
    t.string   "provider"
    t.string   "uid"
    t.string   "role"
    t.string   "sex"
    t.string   "photo"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
