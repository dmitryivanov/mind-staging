class CreateStatusRpts < ActiveRecord::Migration
  def change
    create_table :status_rpts do |t|
      t.string :status_id
      t.text :description
      t.string :error_msg

      t.timestamps
    end
  end
end
