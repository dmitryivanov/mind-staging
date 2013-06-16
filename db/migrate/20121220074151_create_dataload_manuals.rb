class CreateDataloadManuals < ActiveRecord::Migration
  def change
    create_table :dataload_manuals do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :s3_id
      t.string :table_name

      t.timestamps
    end
  end
end
