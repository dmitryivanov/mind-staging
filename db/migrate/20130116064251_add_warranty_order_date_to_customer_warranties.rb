class AddWarrantyOrderDateToCustomerWarranties < ActiveRecord::Migration
  def change
    add_column :customer_warranties, :warranty_order_date, :date
  end
end
