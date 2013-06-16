class CreateCustomerWarranties < ActiveRecord::Migration
  def up
    create_table :customer_warranties, :force => true do |t|
      t.string   "customer_id"
      t.string   "warranty_part_no"
      t.string   "warranty_part_desc"
      t.string   "length_lace_pack"
      t.date     "warranty_order"
      t.datetime "created_at",          :null => false
      t.datetime "updated_at",          :null => false
      t.date     "warranty_order_date"
    end
    
    OldCustomerWarranty.all.each do |old_record|
      CustomerWarranty.new(old_record.attributes) { |new_record| new_record.id = old_record.id }.save!
    end
  end
  
  def down
    drop_table :customer_warranties
  end
end
