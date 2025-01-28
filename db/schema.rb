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

ActiveRecord::Schema[8.0].define(version: 2025_01_27_225626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservation_pricings", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.integer "payout_price_cents", default: 0, null: false
    t.integer "security_price_cents", default: 0, null: false
    t.integer "total_price_cents", default: 0, null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_pricings_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.string "start_date", null: false
    t.string "end_date", null: false
    t.integer "nights", null: false
    t.integer "guests"
    t.integer "adults"
    t.integer "children"
    t.integer "infants"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

  add_foreign_key "reservation_pricings", "reservations"
  add_foreign_key "reservations", "guests"
end
