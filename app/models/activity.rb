class Activity < ActiveRecord::RdsDb
  #attr_accessible :name
  has_many :activity_references
  has_many :customers, :through => :activity_references
end
