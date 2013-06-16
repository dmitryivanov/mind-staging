class DataloadFtp < ActiveRecord::Base
  attr_accessible :/, :file_name, :ftp_directory, :ftp_password, :ftp_url, :ftp_username, :request_user, :s3_id, :schedule, :success_ind, :table_name
end
