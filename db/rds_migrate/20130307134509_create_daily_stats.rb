class CreateDailyStats < ActiveRecord::Migration
  def change
    create_table :daily_stats do |t|
      t.references :mailchimp_campaign
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
      
      t.timestamps
    end
  end
end
