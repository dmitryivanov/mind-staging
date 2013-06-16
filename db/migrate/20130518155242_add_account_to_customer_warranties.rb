class AddAccountToCustomerWarranties < ActiveRecord::Migration
  def change
    add_column :customer_warranties, :account_id, :integer
  end
end
