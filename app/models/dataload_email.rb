class DataloadEmail < ActiveRecord::Base
  attr_accessible :/, :attachment_name, :email_label, :email_password, :email_username, :file_name, :request_user, :s3_id, :schedule, :success_ind, :table_name
end
