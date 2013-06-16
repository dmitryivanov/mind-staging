class CreateMailchimpCampaigns < ActiveRecord::Migration
  def up
    create_table :mailchimp_campaigns, :force => true do |t|
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
    
    OldMailchimpCampaign.all.each do |old_record|
      MailchimpCampaign.new(old_record.attributes) { |new_record| new_record.id = old_record.id }.save!
    end
  end
  
  def down
    drop_table :mailchimp_campaigns
  end
end
