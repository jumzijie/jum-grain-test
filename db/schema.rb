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

ActiveRecord::Schema.define(version: 20180204053641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delivery_orders", force: :cascade do |t|
    t.string   "order_id"
    t.datetime "serving_datetime"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "ratable_type"
    t.integer  "ratable_id"
    t.integer  "rating"
    t.string   "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ratable_type", "ratable_id"], name: "index_feedbacks_on_ratable_type_and_ratable_id", using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.string   "byline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "delivery_order_id"
    t.datetime "serving_date"
    t.integer  "meal_id"
    t.integer  "quantity"
    t.integer  "unit_price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["delivery_order_id"], name: "index_order_items_on_delivery_order_id", using: :btree
    t.index ["meal_id"], name: "index_order_items_on_meal_id", using: :btree
  end

  add_foreign_key "order_items", "delivery_orders"
  add_foreign_key "order_items", "meals"
end
