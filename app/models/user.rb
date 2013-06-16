class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :confirmable,
  # :lockable,
  # :timeoutable,
  # :omniauthable
  # :registerable,
  # :recoverable,
  # :rememberable,
  # :trackable
  devise :database_authenticatable, :validatable
  
  #add multi-tenant 
  acts_as_tenant(:account)
  #validates_uniqueness_to_tenant :email
  belongs_to :account#, :inverse_of => :users
  #validates :account, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  has_one  :dataload_mailchimp
  has_many :dataload_manuals
  has_many :dataload_logs
end
