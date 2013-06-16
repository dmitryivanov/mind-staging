class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.string :name

      t.timestamps
    end
    
    OldActivity.all.each do |old_record|
      Activity.new(old_record.attributes) { |new_record| new_record.id = old_record.id }.save!
    end
  end
  
  def down
    drop_table :activities
  end
end