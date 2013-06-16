class MailchimpList < ActiveRecord::Base
  attr_accessible :list_id, :name, :subscr_download_last_runned_at, :subscr_upload_last_runned_at
  has_many :mailchimp_list_references
  has_many :customers, :through => :mailchimp_list_references
end
