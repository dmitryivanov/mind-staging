class RemoveWarrantyPartDescFromCustomers < ActiveRecord::Migration
    def change
        remove_column :customers, :warranty_part_desc
    end
end
