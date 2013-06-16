class CreateCustomerWarranties < ActiveRecord::Migration
  def change
    create_table :customer_warranties do |t|
        t.string :customer_id
        t.string :warranty_part_no
        t.string :warranty_part_desc
        t.string :length_lace_pack
        t.date :warranty_order

        t.timestamps
    end
  end
end
