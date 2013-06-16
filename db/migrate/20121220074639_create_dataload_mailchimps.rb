class CreateDataloadMailchimps < ActiveRecord::Migration
  def change
    create_table :dataload_mailchimps do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :table_name
      t.string :mc_username
      t.string :mc_password
      t.string :campaigns
      t.string :metrics
      t.string :schedule

      t.timestamps
    end
  end
end
