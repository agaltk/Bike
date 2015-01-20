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

ActiveRecord::Schema.define(version: 20150116203621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "activityType"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "tcx_file_name"
    t.string   "tcx_content_type"
    t.integer  "tcx_file_size"
    t.datetime "tcx_updated_at"
  end

  create_table "laps", force: :cascade do |t|
    t.integer  "activity_id"
    t.datetime "startTime"
    t.float    "totalTimeSeconds"
    t.float    "distanceMeters"
    t.float    "calories"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "laps", ["activity_id"], name: "index_laps_on_activity_id", using: :btree

  create_table "rides", force: :cascade do |t|
    t.datetime "date"
    t.integer  "duration"
    t.float    "average"
    t.float    "max"
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rides_users", force: :cascade do |t|
    t.integer "ride_id"
    t.integer "user_id"
  end

  create_table "trackpoints", force: :cascade do |t|
    t.integer  "track_id"
    t.float    "latitudeDegrees"
    t.float    "longitudeDegrees"
    t.float    "altitudeMeters"
    t.datetime "time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "trackpoints", ["track_id"], name: "index_trackpoints_on_track_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "lap_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tracks", ["lap_id"], name: "index_tracks_on_lap_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.date     "birth_date"
    t.string   "name"
    t.string   "surname"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "laps", "activities"
  add_foreign_key "trackpoints", "tracks"
  add_foreign_key "tracks", "laps"
end
