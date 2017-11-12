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

ActiveRecord::Schema.define(version: 20171112164731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "giftings", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "giftee_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "confirm_token"
    t.integer  "state",          default: 0
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "party_id"
    t.string   "name"
    t.string   "email"
    t.boolean  "party_owner"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "gift_preferences", default: [],              array: true
    t.integer  "family_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string   "name"
    t.string   "passphrase"
    t.integer  "spending_limit"
    t.string   "theme"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "gift_options",   default: [],              array: true
  end

end
