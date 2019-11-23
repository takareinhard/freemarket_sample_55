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

ActiveRecord::Schema.define(version: 20191121122442) do

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "credit_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                   null: false
    t.string   "customer_id",               null: false
    t.string   "card_id",     default: "0", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "card_token"
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "prefecture"
  end

  create_table "product_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image",      null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id", using: :btree
  end

  create_table "product_sizes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "size",       null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_sizes_on_product_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                      null: false
    t.integer  "price",                                     null: false
    t.text     "detail",          limit: 65535,             null: false
    t.integer  "condition",                                 null: false
    t.integer  "postage_payer",                             null: false
    t.integer  "shipping_area",                             null: false
    t.integer  "shipping_days",                             null: false
    t.integer  "deal",                          default: 0
    t.integer  "category_id",                               null: false
    t.integer  "user_id",                                   null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "shipping_method",                           null: false
    t.integer  "brand_id"
    t.integer  "prefecture_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["name"], name: "index_products_on_name", using: :btree
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",                      null: false
    t.string   "first_name",      limit: 50,    null: false
    t.string   "last_name",       limit: 50,    null: false
    t.string   "first_name_kana", limit: 50,    null: false
    t.string   "last_name_kana",  limit: 50,    null: false
    t.integer  "post_number"
    t.integer  "prefecture"
    t.string   "city"
    t.string   "house_number"
    t.string   "building_name"
    t.date     "birthday",                      null: false
    t.integer  "tel_number"
    t.text     "profile",         limit: 65535
    t.string   "avator"
    t.integer  "user_id",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rate"
    t.integer  "user_id",                  null: false
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_rates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "earnings",               default: 0
    t.integer  "points",                 default: 0
    t.string   "card_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password",               default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "credit_cards", "users"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_sizes", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "rates", "users"
end
