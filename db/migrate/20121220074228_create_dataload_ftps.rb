class CreateDataloadFtps < ActiveRecord::Migration
  def change
    create_table :dataload_ftps do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :s3_id
      t.string :table_name
      t.string :ftp_url
      t.string :ftp_username
      t.string :ftp_password
      t.string :ftp_directory
      t.string :schedule

      t.timestamps
    end
  end
end
