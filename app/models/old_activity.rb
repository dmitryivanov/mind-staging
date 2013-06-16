#
# Activity model and table was moved to RDS
# this model & table was left to safely move data
# and can be deleted later
#
class OldActivity < ActiveRecord::Base
  self.table_name = 'activities'
  attr_accessible :name
  has_many :activity_references
  has_many :customers, :through => :activity_references
end
