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

ActiveRecord::Schema.define(version: 20160303201100) do

  create_table "customers", force: :cascade do |t|
    t.string   "mobile_number"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "deactivated"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "store_id"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["store_id"], name: "index_items_on_store_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id"
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "partner_id"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"
  add_index "orders", ["partner_id"], name: "index_orders_on_partner_id"

  create_table "partners", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "deactivated"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "lng"
    t.string   "lat"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "county"
    t.string   "postcode"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "deactivated"
  end

end
