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

ActiveRecord::Schema.define(version: 2019_04_11_183526) do

  create_table "addresses", force: :cascade do |t|
    t.text "recipient"
    t.string "street"
    t.string "city"
    t.string "zip"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.string "email"
    t.index ["order_id"], name: "index_addresses_on_order_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.text "title"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comics", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "pages"
    t.string "cover"
    t.string "cover_image"
    t.string "color"
    t.string "dimensions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "released"
    t.integer "product_id"
    t.boolean "is_virtual"
    t.text "pp_button"
    t.boolean "featured"
    t.integer "position"
    t.text "teaser"
    t.string "title_image"
    t.index ["name"], name: "index_comics_on_name", unique: true
    t.index ["product_id"], name: "index_comics_on_product_id"
  end

  create_table "commission_images", force: :cascade do |t|
    t.string "path"
    t.integer "position"
    t.integer "commission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_id"], name: "index_commission_images_on_commission_id"
  end

  create_table "commissions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "country_code"
    t.string "country_name"
    t.decimal "shipping_price", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "download_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "images", force: :cascade do |t|
    t.integer "comic_id"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_images_on_comic_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.decimal "unit_price", precision: 12, scale: 3
    t.integer "quantity", default: 0
    t.decimal "total_price", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tax", precision: 12, scale: 3
    t.integer "edition_number"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "subtotal", precision: 12, scale: 3
    t.decimal "tax", precision: 12, scale: 3
    t.decimal "shipping", precision: 12, scale: 3
    t.decimal "total", precision: 12, scale: 3
    t.integer "order_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "address_id"
    t.boolean "agreement"
    t.string "order_number"
    t.integer "user_id"
    t.string "slug"
    t.integer "payment_choice_id"
    t.integer "payment_fee"
    t.datetime "placed_on"
    t.datetime "shipped_on"
    t.datetime "cancelled_on"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["payment_choice_id"], name: "index_orders_on_payment_choice_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_choices", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "fee"
    t.string "fee_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.integer "taxrate"
    t.decimal "weight", precision: 12, scale: 3
    t.string "meta_title"
    t.text "meta_description"
    t.integer "quantity"
    t.string "package"
    t.string "cover_image"
    t.datetime "release_date"
    t.string "language"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "limited"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.boolean "is_virtual"
    t.text "pp_button"
    t.boolean "featured"
    t.integer "position"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "webcomic_chapters", force: :cascade do |t|
    t.integer "webcomic_id"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "webcomic_page_id"
    t.integer "chapter_number"
    t.index ["webcomic_id"], name: "index_webcomic_chapters_on_webcomic_id"
    t.index ["webcomic_page_id"], name: "index_webcomic_chapters_on_webcomic_page_id"
  end

  create_table "webcomic_pages", force: :cascade do |t|
    t.integer "webcomic_id"
    t.string "path"
    t.integer "page_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "webcomic_chapter_id"
    t.index ["webcomic_chapter_id"], name: "index_webcomic_pages_on_webcomic_chapter_id"
    t.index ["webcomic_id"], name: "index_webcomic_pages_on_webcomic_id"
  end

  create_table "webcomics", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_image"
    t.string "slug"
    t.integer "position"
  end

end
