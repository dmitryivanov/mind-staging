class AddUserIdToDataloadLogs < ActiveRecord::Migration
  def change
    add_column :dataload_logs, :user_id, :integer
  end
end
