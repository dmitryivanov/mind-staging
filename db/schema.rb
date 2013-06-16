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

ActiveRecord::Schema.define(:version => 20130526223740) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
  end

  create_table "activity_references", :force => true do |t|
    t.integer "activity_id"
    t.integer "customer_id"
    t.integer "account_id"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "campaign_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "account_id"
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
    t.integer  "account_id"
  end

  create_table "dashboard_modules", :force => true do |t|
    t.integer  "dashboard_id"
    t.string   "module_type"
    t.text     "notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "dimension"
    t.string   "metric"
    t.string   "table"
    t.string   "dimension_value"
    t.string   "date"
    t.integer  "account_id"
    t.string   "calculation_type"
  end

  create_table "dashboards", :force => true do |t|
    t.string   "dashboard_id"
    t.string   "module"
    t.string   "source_system"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "name"
    t.string   "description"
    t.integer  "account_id"
  end

  create_table "dataload_emails", :force => true do |t|
    t.string   "/"
    t.string   "file_name"
    t.string   "request_user"
    t.string   "success_ind"
    t.string   "s3_id"
    t.string   "table_name"
    t.string   "email_username"
    t.string   "email_password"
    t.string   "email_label"
    t.string   "schedule"
    t.string   "attachment_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "account_id"
  end

  create_table "dataload_ftps", :force => true do |t|
    t.string   "/"
    t.string   "file_name"
    t.string   "request_user"
    t.string   "success_ind"
    t.string   "s3_id"
    t.string   "table_name"
    t.string   "ftp_url"
    t.string   "ftp_username"
    t.string   "ftp_password"
    t.string   "ftp_directory"
    t.string   "schedule"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "account_id"
  end

  create_table "dataload_gas", :force => true do |t|
    t.string   "/"
    t.string   "file_name"
    t.string   "request_user"
    t.string   "success_ind"
    t.string   "s3_id"
    t.string   "table_name"
    t.string   "ga_username"
    t.string   "ga_password"
    t.string   "dimensions"
    t.string   "metrics"
    t.string   "schedule"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "ga_account_id"
    t.integer  "ga_profile_id"
    t.string   "dimension"
    t.string   "metric"
    t.string   "update_interval"
    t.string   "title"
    t.string   "form_state",      :default => "new"
    t.integer  "account_id"
  end

  create_table "dataload_logs", :force => true do |t|
    t.string   "dataload_type"
    t.boolean  "is_successfull"
    t.integer  "success_rows"
    t.integer  "error_rows"
    t.text     "error_text"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.string   "status"
    t.integer  "account_id"
  end

  create_table "dataload_mailchimps", :force => true do |t|
    t.integer  "user_id"
    t.string   "api_key"
    t.boolean  "subscr_upload_enabled"
    t.string   "subscr_upload_interval"
    t.boolean  "cmp_update_enabled"
    t.string   "cmp_update_interval"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "cmp_update_last_runned_at"
    t.datetime "subscr_upload_last_runned_at"
    t.boolean  "subscr_download_enabled"
    t.string   "subscr_download_interval"
    t.datetime "subscr_download_last_runned_at"
    t.boolean  "subscr_move_enabled"
    t.string   "subscr_move_interval"
    t.datetime "subscr_move_last_runned_at"
    t.integer  "account_id"
  end

  create_table "dataload_mailchimps_destination_lists", :id => false, :force => true do |t|
    t.integer "dataload_mailchimp_id"
    t.integer "destination_list_id"
    t.integer "account_id"
  end

  add_index "dataload_mailchimps_destination_lists", ["dataload_mailchimp_id", "destination_list_id"], :name => "index_dload_mc_destination_lists_on_dload_mc_id_and_dst_list_id"
  add_index "dataload_mailchimps_destination_lists", ["destination_list_id", "dataload_mailchimp_id"], :name => "index_dload_mc_destination_lists_on_dst_list_id_and_dload_mc_id"

  create_table "dataload_mailchimps_source_lists", :id => false, :force => true do |t|
    t.integer "dataload_mailchimp_id"
    t.integer "source_list_id"
    t.integer "account_id"
  end

  add_index "dataload_mailchimps_source_lists", ["dataload_mailchimp_id", "source_list_id"], :name => "index_dload_mc_source_lists_on_dload_mc_id_and_src_list_id"
  add_index "dataload_mailchimps_source_lists", ["source_list_id", "dataload_mailchimp_id"], :name => "index_dload_mc_source_lists_on_src_list_id_and_dload_mc_id"

  create_table "dataload_manuals", :force => true do |t|
    t.string   "/"
    t.string   "file_name"
    t.string   "request_user"
    t.string   "success_ind"
    t.string   "s3_id"
    t.string   "table_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "dataload"
    t.boolean  "csv_imported"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  create_table "dataloads", :force => true do |t|
    t.string   "source"
    t.string   "succcess_ind"
    t.string   "error_msg"
    t.string   "rows_loaded"
    t.string   "request_user"
    t.string   "file_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "account_id"
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
    t.integer  "account_id"
  end

  create_table "mailchimp_list_references", :force => true do |t|
    t.integer "mailchimp_list_id"
    t.integer "customer_id"
    t.integer "account_id"
  end

  create_table "mailchimp_lists", :force => true do |t|
    t.string   "list_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "name"
    t.datetime "subscr_upload_last_runned_at"
    t.datetime "subscr_download_last_runned_at"
    t.integer  "account_id"
  end

  create_table "status_rpts", :force => true do |t|
    t.string   "status_id"
    t.text     "description"
    t.string   "error_msg"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "account_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "name"
    t.integer  "account_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
