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

ActiveRecord::Schema.define(version: 20160304073520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consults", force: true do |t|
    t.text     "sessionId"
    t.text     "purpose_descrip"
    t.text     "duration"
    t.text     "medications"
    t.text     "allergies"
    t.text     "symptoms"
    t.text     "internal_notes"
    t.string   "treatment_result"
    t.text     "treatment_descrip"
    t.text     "recording"
    t.boolean  "patient_waiting"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.integer  "pharmacy_id"
    t.integer  "slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacies", force: true do |t|
    t.string   "name"
    t.string   "place_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prescriptions", force: true do |t|
    t.string   "name"
    t.string   "dosage"
    t.text     "notes"
    t.integer  "consult_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "slots", force: true do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "hour"
    t.integer  "minute"
    t.boolean  "is_open"
    t.integer  "consult_id"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type"
    t.string   "first_name",                              null: false
    t.string   "last_name",                               null: false
    t.string   "email",                                   null: false
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
    t.string   "phone"
    t.string   "age"
    t.string   "gender"
    t.string   "source"
    t.string   "practice_number"
    t.string   "status",          default: "Not Applied"
    t.string   "password_digest",                         null: false
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
