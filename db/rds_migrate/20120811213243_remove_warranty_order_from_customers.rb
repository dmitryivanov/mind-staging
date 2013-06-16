class RemoveWarrantyOrderFromCustomers < ActiveRecord::Migration
    def change
        remove_column :customers, :warranty_order
    end
end
