class RemoveWarrantyPartNoFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :warranty_part_no
  end
end
