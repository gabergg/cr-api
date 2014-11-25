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

ActiveRecord::Schema.define(version: 20141125070119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beans", force: true do |t|
    t.string   "name"
    t.string   "roaster"
    t.string   "roast"
    t.string   "origin"
    t.string   "location"
    t.string   "review_date"
    t.integer  "overall_rating"
    t.integer  "aroma"
    t.integer  "acidity"
    t.integer  "body"
    t.integer  "flavor"
    t.integer  "aftertaste"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "price"
    t.string   "agtron"
    t.integer  "with_milk"
  end

  add_index "beans", ["location"], name: "index_beans_on_location", using: :btree
  add_index "beans", ["origin"], name: "index_beans_on_origin", using: :btree
  add_index "beans", ["overall_rating"], name: "index_beans_on_overall_rating", using: :btree
  add_index "beans", ["review_date"], name: "index_beans_on_review_date", using: :btree
  add_index "beans", ["roast"], name: "index_beans_on_roast", using: :btree
  add_index "beans", ["roaster"], name: "index_beans_on_roaster", using: :btree

end
