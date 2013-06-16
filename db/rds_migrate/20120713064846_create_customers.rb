class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.date :created_at
      t.string :warranty_part_no
      t.string :warranty_part_desc
      t.string :length_lace_pack
      t.date :warranty_order
      t.string :first_name
      t.string :last_name
      t.string :billing_addr_ln1
      t.string :billing_addr_ln2
      t.string :billing_addr_city
      t.string :billing_addr_state
      t.string :billing_addr_cc
      t.string :billing_addr_zip
      t.string :shipping_addr_ln1
      t.string :shipping_addr_ln2
      t.string :shipping_addr_city
      t.string :shipping_addr_state
      t.string :shipping_addr_cc
      t.string :shipping_addr_zip
      t.string :phone_number
      t.string :email_addr

      t.timestamps
    end
  end
end
