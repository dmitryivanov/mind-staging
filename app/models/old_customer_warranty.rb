#
# Customer warranties model and table was moved to RDS
# this model & table was left to safely move data
# and can be deleted later
#
class OldCustomerWarranty < ActiveRecord::Base
  self.table_name = 'customer_warranties'
end
