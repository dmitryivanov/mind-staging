class CreateCustomerFacts < ActiveRecord::Migration
  def change
    create_table :customer_facts do |t|
        t.string :customer_id
        t.string :customer_warranty_id

        t.timestamps
    end
  end
end
