class CreateDataloadGas < ActiveRecord::Migration
  def change
    create_table :dataload_gas do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :s3_id
      t.string :table_name
      t.string :ga_username
      t.string :ga_password
      t.string :dimensions
      t.string :metrics
      t.string :schedule

      t.timestamps
    end
  end
end
