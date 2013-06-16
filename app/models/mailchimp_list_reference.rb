class MailchimpListReference < ActiveRecord::Base
  attr_accessible :mailchimp_list_id, :customer_id
  belongs_to :mailchimp_list
  belongs_to :customer
end
