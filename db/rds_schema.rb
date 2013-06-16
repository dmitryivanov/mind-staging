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

ActiveRecord::Schema.define(:version => 20130319070628) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "activity_references", :force => true do |t|
    t.integer "activity_id"
    t.integer "customer_id"
  end

  create_table "customer_facts", :force => true do |t|
    t.string   "customer_id"
    t.string   "customer_warranty_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "customer_warranties", :force => true do |t|
    t.string   "customer_id"
    t.string   "warranty_part_no"
    t.string   "warranty_part_desc"
    t.string   "length_lace_pack"
    t.date     "warranty_order"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.date     "warranty_order_date"
  end

  create_table "customers", :force => true do |t|
    t.string   "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "billing_addr_ln1"
    t.string   "billing_addr_ln2"
    t.string   "billing_addr_city"
    t.string   "billing_addr_state"
    t.string   "billing_addr_cc"
    t.string   "billing_addr_zip"
    t.string   "shipping_addr_ln1"
    t.string   "shipping_addr_ln2"
    t.string   "shipping_addr_city"
    t.string   "shipping_addr_state"
    t.string   "shipping_addr_cc"
    t.string   "shipping_addr_zip"
    t.string   "phone_number"
    t.string   "email_addr"
    t.datetime "updated_at",               :null => false
    t.integer  "foreign_id"
    t.date     "subscribe_date"
    t.date     "unsubscribe_date"
    t.date     "clean_date"
    t.string   "email_subscription_state"
    t.string   "email_permission_state"
    t.datetime "created_at"
  end

  create_table "daily_stats", :force => true do |t|
    t.integer  "mailchimp_campaign_id"
    t.integer  "syntax_errors"
    t.integer  "hard_bounces"
    t.integer  "soft_bounces"
    t.integer  "unsubscribes"
    t.integer  "abuse_reports"
    t.integer  "forwards"
    t.integer  "forwards_opens"
    t.integer  "opens"
    t.datetime "last_open"
    t.integer  "unique_opens"
    t.integer  "clicks"
    t.integer  "unique_clicks"
    t.integer  "users_who_clicked"
    t.datetime "last_click"
    t.integer  "emails_sent"
    t.integer  "unique_likes"
    t.integer  "recipient_likes"
    t.integer  "facebook_likes"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "mailchimp_campaigns", :force => true do |t|
    t.string   "mailchimp_id"
    t.string   "title"
    t.integer  "syntax_errors"
    t.integer  "hard_bounces"
    t.integer  "soft_bounces"
    t.integer  "unsubscribes"
    t.integer  "abuse_reports"
    t.integer  "forwards"
    t.integer  "forwards_opens"
    t.integer  "opens"
    t.datetime "last_open"
    t.integer  "unique_opens"
    t.integer  "clicks"
    t.integer  "unique_clicks"
    t.integer  "users_who_clicked"
    t.datetime "last_click"
    t.integer  "emails_sent"
    t.integer  "unique_likes"
    t.integer  "recipient_likes"
    t.integer  "facebook_likes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
