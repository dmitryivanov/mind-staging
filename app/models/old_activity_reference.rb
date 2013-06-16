#
# Activity Reference model and table was moved to RDS
# this model & table was left to safely move data
# and can be deleted later
#
class OldActivityReference < ActiveRecord::Base
  self.table_name = 'activity_references'
  attr_accessible :activity_id, :customer_id
  belongs_to :customer
  belongs_to :activity
end
