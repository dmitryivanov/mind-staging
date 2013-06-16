class MailchimpCampaign < ActiveRecord::RdsDb
  attr_accessible :mailchimp_id, :title,
    :syntax_errors,
    :hard_bounces,
    :soft_bounces,
    :unsubscribes,
    :abuse_reports,
    :forwards,
    :forwards_opens,
    :opens,
    :last_open,
    :unique_opens,
    :clicks,
    :unique_clicks,
    :users_who_clicked,
    :last_click,
    :emails_sent,
    :unique_likes,
    :recipient_likes,
    :facebook_likes,
    :id,          # 
    :created_at,  # these are for cloning data from postgres to RDS
    :updated_at   #
    
  has_many :daily_stats
end
