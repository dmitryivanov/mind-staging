class CreateActivityReferences < ActiveRecord::Migration
  def up
    create_table :activity_references do |t|
      t.integer :activity_id
      t.integer :customer_id
    end
    
    OldActivityReference.all.each do |old_record|
      ActivityReference.new(old_record.attributes) { |new_record| new_record.id = old_record.id }.save!
    end
  end
  
  def down
    drop_table :activity_references
  end
end
