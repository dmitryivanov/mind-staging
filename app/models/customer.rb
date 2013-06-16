class Customer < ActiveRecord::RdsDb
  has_many :activity_references
  has_many :activities, :through => :activity_references
  has_many :mailchimp_list_references
  has_many :mailchimp_lists, :through => :mailchimp_list_references
  has_many :customer_warranties
  
  # NOTE:
  # customer_id is not used right now
  # foreign_id is customer id from uploaded csv
  
  # TODO: will have lots of customers that do not have an email.
  #       and there are cases where an email could appear twice.
  
  # Q: should foreign_id be unique?

  validates_uniqueness_of :email_addr
    
  def self.search(search)
    search.blank? ? [] : all(:conditions => ['name LIKE ?', "%#{search.strip}%"])
  end
  
  state_machine :email_subscription_state, :initial => :not_subscribed do
    state :not_subscribed
    state :subscribed
    state :unsubscribed
    state :cleared
  end
  
  state_machine :email_permission_state, :initial => :not_asked do
    state :not_asked
    state :granted
    state :denied
  end
  
end
