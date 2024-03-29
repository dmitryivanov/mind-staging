class Account < ActiveRecord::Base  
  has_many :users#, :inverse_of => :account, :dependent => :destroy
  accepts_nested_attributes_for :users
  attr_accessible :domain, :users_attributes
end