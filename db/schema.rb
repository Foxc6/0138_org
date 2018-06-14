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

ActiveRecord::Schema.define(version: 20160922211712) do

  create_table "age_ranges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "age_min",    limit: 4
    t.integer  "age_max",    limit: 4
    t.integer  "locale_id",  limit: 4
  end

  add_index "age_ranges", ["locale_id"], name: "index_age_ranges_on_locale_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefit_products", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "benefit_id", limit: 4
    t.integer  "product_id", limit: 4
  end

  add_index "benefit_products", ["benefit_id"], name: "index_benefit_products_on_benefit_id", using: :btree
  add_index "benefit_products", ["product_id"], name: "index_benefit_products_on_product_id", using: :btree

  create_table "benefits", force: :cascade do |t|
    t.string   "name",                             limit: 255
    t.string   "icon_image_file_name",             limit: 255
    t.string   "icon_image_content_type",          limit: 255
    t.integer  "icon_image_file_size",             limit: 4
    t.datetime "icon_image_updated_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "locale_id",                        limit: 4
    t.string   "icon_image_rollover_file_name",    limit: 255
    t.string   "icon_image_rollover_content_type", limit: 255
    t.integer  "icon_image_rollover_file_size",    limit: 4
    t.datetime "icon_image_rollover_updated_at"
  end

  add_index "benefits", ["locale_id"], name: "index_benefits_on_locale_id", using: :btree

  create_table "customer_regimen_products", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "customer_regimen_id", limit: 4
    t.integer  "product_id",          limit: 4
  end

  add_index "customer_regimen_products", ["customer_regimen_id"], name: "index_customer_regimen_products_on_customer_regimen_id", using: :btree
  add_index "customer_regimen_products", ["product_id"], name: "index_customer_regimen_products_on_product_id", using: :btree

  create_table "customer_regimens", force: :cascade do |t|
    t.integer  "customer_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "guide_id",            limit: 4
    t.integer  "original_regimen_id", limit: 4
    t.integer  "age_range_id",        limit: 4
    t.integer  "benefit_id",          limit: 4
    t.integer  "skin_type_id",        limit: 4
  end

  add_index "customer_regimens", ["age_range_id"], name: "index_customer_regimens_on_age_range_id", using: :btree
  add_index "customer_regimens", ["benefit_id"], name: "index_customer_regimens_on_benefit_id", using: :btree
  add_index "customer_regimens", ["customer_id"], name: "index_customer_regimens_on_customer_id", using: :btree
  add_index "customer_regimens", ["guide_id"], name: "index_customer_regimens_on_guide_id", using: :btree
  add_index "customer_regimens", ["skin_type_id"], name: "index_customer_regimens_on_skin_type_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "email",            limit: 255
    t.boolean  "newsletter_optin"
    t.boolean  "email_optin"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "locale_id",        limit: 4
  end

  add_index "customers", ["locale_id"], name: "index_customers_on_locale_id", using: :btree

  create_table "genders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "locale_id",  limit: 4
    t.boolean  "is_male"
  end

  add_index "genders", ["locale_id"], name: "index_genders_on_locale_id", using: :btree

  create_table "guides", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "locale_id",  limit: 4
  end

  add_index "guides", ["locale_id"], name: "index_guides_on_locale_id", using: :btree

  create_table "locales", force: :cascade do |t|
    t.string   "code",            limit: 255
    t.string   "fb_locale",       limit: 255
    t.string   "fb_page",         limit: 255
    t.string   "fb_page_id",      limit: 255
    t.string   "redirect_link",   limit: 255
    t.string   "logo_link",       limit: 255
    t.boolean  "active",                      default: false
    t.boolean  "isAPAC",                      default: false
    t.string   "tracking_code",   limit: 255
    t.string   "tracking_domain", limit: 255
    t.string   "twitter_link",    limit: 255
    t.string   "name",            limit: 255
    t.string   "facebook_url",    limit: 255
    t.string   "twitter_url",     limit: 255
    t.string   "youtube_url",     limit: 255
    t.string   "pinterest_url",   limit: 255
    t.string   "instagram_url",   limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject",             limit: 255
    t.string   "to",                  limit: 255
    t.text     "body",                limit: 65535
    t.string   "message_type",        limit: 255
    t.string   "template",            limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "customer_regimen_id", limit: 4
  end

  add_index "messages", ["customer_regimen_id"], name: "index_messages_on_customer_regimen_id", using: :btree

  create_table "option_types", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "presentation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "locale_id",    limit: 4
  end

  add_index "option_types", ["locale_id"], name: "index_option_types_on_locale_id", using: :btree

  create_table "option_values", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "option_type_id", limit: 4
    t.string   "presentation",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id", using: :btree

  create_table "option_values_variants", force: :cascade do |t|
    t.integer  "option_value_id", limit: 4
    t.integer  "variant_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "option_values_variants", ["option_value_id"], name: "index_option_values_variants_on_option_value_id", using: :btree
  add_index "option_values_variants", ["variant_id"], name: "index_option_values_variants_on_variant_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "company",              limit: 255
    t.string   "url",                  limit: 255
    t.text     "meta_description",     limit: 65535
    t.text     "meta_keywords",        limit: 65535
    t.string   "seo_title",            limit: 255
    t.string   "mail_from_address",    limit: 255
    t.boolean  "default",                            default: false, null: false
    t.string   "logo_file_name",       limit: 255
    t.string   "logo_content_type",    limit: 255
    t.integer  "logo_file_size",       limit: 4
    t.datetime "logo_updated_at"
    t.integer  "default_country_code", limit: 4
    t.boolean  "is_domestic",                        default: true
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "locale_id",            limit: 4
  end

  add_index "preferences", ["locale_id"], name: "index_preferences_on_locale_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "slug",         limit: 255
    t.integer  "position",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "locale_id",    limit: 4
    t.integer  "parent_id",    limit: 4
    t.boolean  "is_male_only"
  end

  add_index "product_categories", ["locale_id"], name: "index_product_categories_on_locale_id", using: :btree

  create_table "product_option_types", force: :cascade do |t|
    t.integer  "position",       limit: 4
    t.integer  "product_id",     limit: 4
    t.integer  "option_type_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "product_option_types", ["option_type_id"], name: "index_product_option_types_on_option_type_id", using: :btree
  add_index "product_option_types", ["product_id"], name: "index_product_option_types_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "franchise_name",      limit: 255
    t.string   "name",                limit: 255
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.integer  "image_file_size",     limit: 4
    t.datetime "image_updated_at"
    t.boolean  "is_new"
    t.string   "active_ingredient",   limit: 255
    t.text     "description",         limit: 65535
    t.integer  "position",            limit: 4
    t.string   "seo_url",             limit: 255
    t.boolean  "active"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "collection",          limit: 255
    t.integer  "locale_id",           limit: 4
    t.integer  "product_category_id", limit: 4
    t.integer  "origins_prodid",      limit: 4
    t.string   "ecomm_url",           limit: 255
  end

  add_index "products", ["locale_id"], name: "index_products_on_locale_id", using: :btree
  add_index "products", ["product_category_id"], name: "index_products_on_product_category_id", using: :btree

  create_table "products_regimens", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4, null: false
    t.integer "regimen_id", limit: 4, null: false
  end

  add_index "products_regimens", ["product_id", "regimen_id"], name: "index_products_regimens_on_product_id_and_regimen_id", using: :btree
  add_index "products_regimens", ["regimen_id", "product_id"], name: "index_products_regimens_on_regimen_id_and_product_id", using: :btree

  create_table "products_skin_types", id: false, force: :cascade do |t|
    t.integer "product_id",   limit: 4, null: false
    t.integer "skin_type_id", limit: 4, null: false
  end

  add_index "products_skin_types", ["product_id", "skin_type_id"], name: "index_products_skin_types_on_product_id_and_skin_type_id", using: :btree
  add_index "products_skin_types", ["skin_type_id", "product_id"], name: "index_products_skin_types_on_skin_type_id_and_product_id", using: :btree

  create_table "regimens", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "age_range_id",  limit: 4
    t.integer  "benefit_id",    limit: 4
    t.integer  "gender_id",     limit: 4
    t.integer  "locale_id",     limit: 4
    t.integer  "age_range_min", limit: 4
    t.integer  "age_range_max", limit: 4
  end

  add_index "regimens", ["age_range_id"], name: "index_regimens_on_age_range_id", using: :btree
  add_index "regimens", ["benefit_id"], name: "index_regimens_on_benefit_id", using: :btree
  add_index "regimens", ["gender_id"], name: "index_regimens_on_gender_id", using: :btree
  add_index "regimens", ["locale_id"], name: "index_regimens_on_locale_id", using: :btree

  create_table "regimens_skin_types", id: false, force: :cascade do |t|
    t.integer "regimen_id",   limit: 4, null: false
    t.integer "skin_type_id", limit: 4, null: false
  end

  add_index "regimens_skin_types", ["regimen_id", "skin_type_id"], name: "index_regimens_skin_types_on_regimen_id_and_skin_type_id", using: :btree
  add_index "regimens_skin_types", ["skin_type_id", "regimen_id"], name: "index_regimens_skin_types_on_skin_type_id_and_regimen_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "skin_types", force: :cascade do |t|
    t.string   "name",                             limit: 255
    t.string   "icon_image_file_name",             limit: 255
    t.string   "icon_image_content_type",          limit: 255
    t.integer  "icon_image_file_size",             limit: 4
    t.datetime "icon_image_updated_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "locale_id",                        limit: 4
    t.string   "icon_image_rollover_file_name",    limit: 255
    t.string   "icon_image_rollover_content_type", limit: 255
    t.integer  "icon_image_rollover_file_size",    limit: 4
    t.datetime "icon_image_rollover_updated_at"
  end

  add_index "skin_types", ["locale_id"], name: "index_skin_types_on_locale_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "username",               limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "locale_id",              limit: 4
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["locale_id"], name: "index_users_on_locale_id", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "variants", force: :cascade do |t|
    t.string   "code",             limit: 255
    t.decimal  "weight",                       precision: 10
    t.decimal  "height",                       precision: 10
    t.decimal  "width",                        precision: 10
    t.decimal  "depth",                        precision: 10
    t.boolean  "is_master",                                             default: false
    t.integer  "product_id",       limit: 4
    t.decimal  "price",                        precision: 10, scale: 2, default: 0.0
    t.string   "cost_currency",    limit: 255
    t.string   "position",         limit: 255
    t.string   "track_inventory",  limit: 255
    t.integer  "tax_category_id",  limit: 4
    t.integer  "stock_item_count", limit: 4
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.date     "deleted_at"
    t.string   "upc",              limit: 255
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree

  add_foreign_key "customer_regimens", "customers"
  add_foreign_key "customer_regimens", "guides"
  add_foreign_key "genders", "locales"
  add_foreign_key "option_types", "locales"
  add_foreign_key "option_values", "option_types"
  add_foreign_key "option_values_variants", "option_values"
  add_foreign_key "option_values_variants", "variants"
  add_foreign_key "product_option_types", "option_types"
  add_foreign_key "product_option_types", "products"
  add_foreign_key "variants", "products"
end
