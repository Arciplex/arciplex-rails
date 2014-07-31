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

ActiveRecord::Schema.define(version: 20140731200105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_contacts", force: true do |t|
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "additional_contacts", ["company_id"], name: "index_additional_contacts_on_company_id", using: :btree

  create_table "api_keys", force: true do |t|
    t.string   "access_token",                null: false
    t.integer  "company_id",                  null: false
    t.boolean  "active",       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["company_id"], name: "index_api_keys_on_company_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_manage_orders", default: false
  end

  create_table "company_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "service_request_id"
    t.string   "item_type"
    t.string   "model_number"
    t.string   "serial_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "additional_information"
  end

  create_table "notes", force: true do |t|
    t.integer  "noteable_id",                null: false
    t.integer  "user_id",                    null: false
    t.text     "description",   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "noteable_type"
  end

  create_table "order_line_items", force: true do |t|
    t.integer  "order_id"
    t.string   "item"
    t.string   "quantity"
    t.text     "additional_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "serial_number"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "customer_id"
    t.datetime "received_at"
    t.datetime "ship_date"
    t.string   "status"
    t.string   "tracking_number"
    t.string   "carrier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_requests", force: true do |t|
    t.integer  "customer_id"
    t.text     "troubleshooting_reference"
    t.string   "rma"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "case_number",               limit: 8, null: false
    t.text     "additional_information"
    t.datetime "ship_date"
    t.text     "tracking_number"
    t.text     "carrier"
    t.datetime "completed_at"
    t.integer  "company_id"
    t.datetime "received_at"
    t.string   "creation_source"
    t.string   "creation_identifier"
  end

  create_table "shipping_information", force: true do |t|
    t.integer  "customer_id"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code",     limit: 10
    t.string   "country"
    t.string   "address_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "company_name"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "requestor"
    t.boolean  "receives_communication", default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
