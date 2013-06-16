class CreateDataloadEmails < ActiveRecord::Migration
  def change
    create_table :dataload_emails do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :s3_id
      t.string :table_name
      t.string :email_username
      t.string :email_password
      t.string :email_label
      t.string :schedule
      t.string :attachment_name

      t.timestamps
    end
  end
end
