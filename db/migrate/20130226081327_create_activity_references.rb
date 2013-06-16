class CreateActivityReferences < ActiveRecord::Migration
  def change
    create_table :activity_references do |t|
      t.integer :activity_id
      t.integer :customer_id
    end
  end
end
