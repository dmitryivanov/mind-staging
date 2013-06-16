class RemoveLengthLacePackFromCustomers < ActiveRecord::Migration
    def change
        remove_column :customers, :length_lace_pack
    end
end
