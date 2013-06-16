#
# Mailchimp campaigns model and table was moved to RDS
# this model & table was left to safely move data
# and can be deleted later
#
class OldMailchimpCampaign < ActiveRecord::Base
  self.table_name = 'mailchimp_campaigns'
  
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
    :facebook_likes
end
