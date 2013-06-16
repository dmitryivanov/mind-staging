class Dashboard < ActiveRecord::Base
  has_many :dashboard_modules, :dependent => :destroy
end
