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

ActiveRecord::Schema.define(:version => 20130328004443) do

  create_table "admins", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories_events", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "zip"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "performer"
    t.text     "description"
    t.text     "artistic_credit"
    t.date     "historic_date"
    t.string   "historic_description"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "image"
    t.integer  "inventory_number"
    t.string   "kind"
    t.string   "title"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.string   "image2"
    t.string   "location"
    t.string   "address"
    t.string   "zip"
    t.integer  "publish",                                   :default => 1
    t.text     "tessitura_name"
    t.text     "tessitura_description"
    t.string   "credit_image"
    t.text     "ticket_override"
    t.string   "price_range_override"
    t.integer  "historic_year",                :limit => 8
    t.string   "web_address"
    t.string   "date_text_override"
    t.boolean  "show_default_purchase_button"
    t.integer  "ticketing_end",                             :default => 2
  end

  create_table "events_tags", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "event_id"
  end

  create_table "performances", :force => true do |t|
    t.string   "location"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "inventory_number"
    t.datetime "performance_date"
    t.integer  "min_price"
    t.integer  "max_price"
    t.string   "buy_url"
    t.string   "price_range"
    t.datetime "end_date"
    t.integer  "hide_buy_link"
    t.integer  "world_premiere"
    t.integer  "sold_out"
    t.integer  "hide_event"
    t.integer  "event_id"
    t.string   "address"
    t.integer  "zip"
    t.string   "timeslot"
    t.integer  "publish",          :default => 1
  end

  create_table "press_releases", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "title"
    t.text     "contents"
    t.datetime "publish_date"
    t.datetime "release_date"
  end

  create_table "similar_events", :force => true do |t|
    t.integer  "similar_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url_link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.integer  "text_color"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
