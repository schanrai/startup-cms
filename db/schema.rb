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

ActiveRecord::Schema.define(version: 20181222031407) do

  create_table "startup_profiles", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.integer "mentor_id"
    t.text    "description"
    t.integer "year_founded"
    t.string  "website"
    t.string  "stage"
    t.string  "help_needed"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.text   "mentor_description"
    t.string "website"
    t.string "linked_in"
    t.string "location"
  end

end
