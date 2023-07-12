# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_12_110035) do
  create_table "bookings", force: :cascade do |t|
    t.string "order_id"
    t.decimal "total_payment"
    t.integer "user_id"
    t.integer "gslot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.text "user_information"
    t.index ["gslot_id"], name: "index_bookings_on_gslot_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "grounds", force: :cascade do |t|
    t.string "name"
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_grounds_on_organization_id"
  end

  create_table "gslots", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.decimal "charge"
    t.string "inprocess"
    t.integer "ground_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ground_id"], name: "index_gslots_on_ground_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_created_at"
    t.string "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "encrypted_password"
    t.string "email"
    t.string "role"
    t.string "phone_number"
    t.string "checkotp"
  end

  add_foreign_key "bookings", "gslots"
  add_foreign_key "bookings", "users"
  add_foreign_key "grounds", "organizations"
  add_foreign_key "gslots", "grounds"
end
