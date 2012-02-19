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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120219062334) do

  create_table "listings", :force => true do |t|
    t.string   "faction"
    t.string   "character"
    t.integer  "race"
    t.string   "realm"
    t.integer  "character_class"
    t.string   "main_spec"
    t.string   "off_spec"
    t.integer  "rating"
    t.string   "rank"
    t.integer  "resilience"
    t.integer  "item_level"
    t.string   "irc_name"
    t.text     "notes"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "gender",          :default => 0
    t.string   "ip_address"
  end

end
