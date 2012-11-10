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

ActiveRecord::Schema.define(:version => 20121110014005) do

  create_table "reservations", :id => false, :force => true do |t|
    t.datetime "starts_at"
    t.string   "name"
    t.integer  "restaurant_id"
    t.string   "confirmation_token"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "phone_number"
    t.integer  "diner_count"
    t.string   "email"
  end

  add_index "reservations", ["confirmation_token"], :name => "index_reservations_on_confirmation_token", :unique => true
  add_index "reservations", ["restaurant_id", "starts_at"], :name => "index_reservations_on_restaurant_id_and_starts_at"

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.integer  "count_tables"
    t.integer  "reservation_length"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "restaurants", ["email"], :name => "index_restaurants_on_email", :unique => true
  add_index "restaurants", ["reset_password_token"], :name => "index_restaurants_on_reset_password_token", :unique => true

end
