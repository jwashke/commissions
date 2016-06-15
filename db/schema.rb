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

ActiveRecord::Schema.define(version: 20160614223908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "imports", force: :cascade do |t|
    t.datetime "time_started"
    t.integer  "prev_quantity_active"
    t.integer  "current_quantity_active"
    t.integer  "total_time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "mls_number"
    t.datetime "last_change_timestamp"
    t.string   "property_type"
    t.string   "status"
    t.integer  "list_price"
    t.string   "street_number"
    t.string   "street_dir"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "unit_number"
    t.string   "building_number"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "county"
    t.string   "parcel_number"
    t.string   "locale"
    t.string   "complex_name"
    t.text     "public_remarks"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "total_baths"
    t.string   "total_bedrooms"
    t.string   "square_feet"
    t.string   "lot_square_acres"
    t.float    "buyer_agency_compensation"
    t.string   "listing_agent_name"
    t.string   "listing_agent_phone"
    t.string   "listing_agent_email"
    t.float    "transaction_broker_compensation"
    t.boolean  "streetview_available"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "signed_docs",            default: false
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
