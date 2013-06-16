class ActivityReference < ActiveRecord::RdsDb
  attr_accessible :activity_id, :customer_id
  belongs_to :customer
  belongs_to :activity
end
