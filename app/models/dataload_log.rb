class DataloadLog < ActiveRecord::Base
  attr_accessible :dataload_type, :error_text, :is_successfull, :success_rows, :error_rows, :user_id, :status
  serialize :error_text
  belongs_to :user
end
