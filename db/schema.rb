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

ActiveRecord::Schema.define(version: 2019_01_07_161013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_logs", force: :cascade do |t|
    t.string "uuid", null: false
    t.text "request_data"
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_api_logs_on_uuid", unique: true
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "user_id"
    t.integer "order_id"
    t.integer "number", null: false
    t.integer "series", null: false
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_coupons_on_order_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
    t.index ["uuid"], name: "index_coupons_on_uuid", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_orders_on_number", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "document", null: false
    t.string "email", null: false
    t.string "name"
    t.string "surname"
    t.string "phone"
    t.string "mobile_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
