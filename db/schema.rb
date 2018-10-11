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

ActiveRecord::Schema.define(version: 20161110213151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "city_id",                                                        null: false
    t.integer  "related_id",                                                     null: false
    t.string   "related_type",                                                   null: false
    t.string   "street",                                                         null: false
    t.string   "complement"
    t.integer  "number",                                             default: 0, null: false
    t.string   "district",                                                       null: false
    t.string   "zipcode",         limit: 8,                                      null: false
    t.decimal  "lat",                       precision: 14, scale: 6
    t.decimal  "long",                      precision: 14, scale: 6
    t.string   "reference_point",                                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["related_type", "related_id"], name: "index_addresses_on_related_type_and_related_id", using: :btree

  create_table "churches", force: :cascade do |t|
    t.string   "name",       limit: 150,                null: false
    t.integer  "address_id"
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "churches", ["address_id"], name: "index_churches_on_address_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 150,                null: false
    t.integer  "state_id",                              null: false
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "congregateds", force: :cascade do |t|
    t.string   "name",       limit: 150,                 null: false
    t.date     "birth_dt",                               null: false
    t.date     "entry_dt",                               null: false
    t.boolean  "baptized",               default: false
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 60
    t.string   "acronym",    limit: 2
    t.boolean  "active",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name",       limit: 150,                null: false
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: :cascade do |t|
    t.string   "name",               limit: 150,                null: false
    t.string   "father_name",        limit: 150,                null: false
    t.string   "mother_name",        limit: 150,                null: false
    t.integer  "post_id"
    t.integer  "naturalness_id"
    t.integer  "job_id"
    t.date     "convert_dt",                                    null: false
    t.date     "birth_dt",                                      null: false
    t.string   "gender",             limit: 1,                  null: false
    t.string   "educational_level",  limit: 2,                  null: false
    t.string   "marital_status",     limit: 2,                  null: false
    t.boolean  "active",                         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "email"
  end

  add_index "members", ["job_id"], name: "index_members_on_job_id", using: :btree
  add_index "members", ["naturalness_id"], name: "index_members_on_naturalness_id", using: :btree
  add_index "members", ["post_id"], name: "index_members_on_post_id", using: :btree

  create_table "permits", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "modulus",    null: false
    t.string   "controller", null: false
    t.string   "action",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permits", ["action"], name: "index_permits_on_action", using: :btree
  add_index "permits", ["controller"], name: "index_permits_on_controller", using: :btree
  add_index "permits", ["modulus"], name: "index_permits_on_modulus", using: :btree
  add_index "permits", ["name"], name: "index_permits_on_name", using: :btree

  create_table "phone_carriers", force: :cascade do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "number",                                       null: false
    t.integer  "related_id",                                   null: false
    t.string   "related_type",                                 null: false
    t.integer  "phone_carrier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_type",       limit: 10, default: "home", null: false
    t.boolean  "whatsapp",                    default: true,   null: false
  end

  add_index "phones", ["related_type", "related_id"], name: "index_phones_on_related_type_and_related_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "name",           limit: 150,                null: false
    t.string   "classification", limit: 1,                  null: false
    t.boolean  "active",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "related_id",   null: false
    t.string   "related_type", null: false
    t.integer  "permit_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["permit_id"], name: "index_roles_on_permit_id", using: :btree
  add_index "roles", ["related_id"], name: "index_roles_on_related_id", using: :btree
  add_index "roles", ["related_type"], name: "index_roles_on_related_type", using: :btree

  create_table "shepherds", force: :cascade do |t|
    t.string   "name",       limit: 150,                null: false
    t.integer  "church_id"
    t.date     "birth_dt",                              null: false
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shepherds", ["church_id"], name: "index_shepherds_on_church_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 60
    t.string   "acronym",    limit: 2
    t.integer  "country_id",                           null: false
    t.boolean  "active",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "user_password_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_permits", force: :cascade do |t|
    t.integer  "permit_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_permits", ["permit_id"], name: "index_user_permits_on_permit_id", using: :btree
  add_index "user_permits", ["user_id"], name: "index_user_permits_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                              default: "",        null: false
    t.string   "encrypted_password",                 default: "",        null: false
    t.boolean  "admin",                              default: false,     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0,         null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.boolean  "administrator",                      default: false,     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "secret_phrase",          limit: 30,  default: "default", null: false
    t.boolean  "locked",                             default: true
    t.boolean  "active",                             default: true,      null: false
    t.string   "name",                   limit: 150,                     null: false
  end

  add_index "users", ["active"], name: "index_users_on_active", using: :btree
  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "cities"
  add_foreign_key "cities", "states"
  add_foreign_key "members", "cities", column: "naturalness_id"
  add_foreign_key "members", "jobs"
  add_foreign_key "members", "posts"
  add_foreign_key "phones", "phone_carriers"
  add_foreign_key "roles", "permits"
  add_foreign_key "states", "countries"
  add_foreign_key "user_password_histories", "users"
  add_foreign_key "user_permits", "permits"
  add_foreign_key "user_permits", "users"
end
