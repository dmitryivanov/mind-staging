class AddStatusToDataloadLogs < ActiveRecord::Migration
  def change
    add_column :dataload_logs, :status, :string
  end
end
