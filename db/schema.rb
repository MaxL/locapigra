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

ActiveRecord::Schema.define(version: 20161215184250) do

  create_table "addresses", force: :cascade do |t|
    t.text     "recipient"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.string   "email"
  end

  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id"

  create_table "comics", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "pages"
    t.string   "cover"
    t.string   "cover_image"
    t.string   "color"
    t.string   "dimensions"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.boolean  "released"
    t.integer  "product_id"
  end

  add_index "comics", ["name"], name: "index_comics_on_name", unique: true
  add_index "comics", ["product_id"], name: "index_comics_on_product_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "destinations", force: :cascade do |t|
    t.string   "country_code"
    t.string   "country_name"
    t.decimal  "shipping_price", precision: 12, scale: 3
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "images", force: :cascade do |t|
    t.integer  "comic_id"
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["comic_id"], name: "index_images_on_comic_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",     precision: 12, scale: 3
    t.integer  "quantity",                                default: 0
    t.decimal  "total_price",    precision: 12, scale: 3
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "tax",            precision: 12, scale: 3
    t.integer  "edition_number"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",          precision: 12, scale: 3
    t.decimal  "tax",               precision: 12, scale: 3
    t.decimal  "shipping",          precision: 12, scale: 3
    t.decimal  "total",             precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "address_id"
    t.boolean  "agreement"
    t.string   "order_number"
    t.integer  "user_id"
    t.string   "slug"
    t.integer  "payment_choice_id"
    t.integer  "payment_fee"
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id"
  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id"
  add_index "orders", ["payment_choice_id"], name: "index_orders_on_payment_choice_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payment_choices", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "fee"
    t.string   "fee_kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "active"
  end

  create_table "products", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.decimal  "price",            precision: 12, scale: 3
    t.integer  "taxrate"
    t.decimal  "weight",           precision: 12, scale: 3
    t.string   "meta_title"
    t.text     "meta_description"
    t.integer  "quantity"
    t.string   "package"
    t.string   "cover_image"
    t.datetime "release_date"
    t.string   "language"
    t.boolean  "active"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "slug"
    t.integer  "price_cents",                               default: 0,     null: false
    t.string   "price_currency",                            default: "EUR", null: false
    t.boolean  "limited"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
