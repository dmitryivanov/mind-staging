class AddAccountToDataloadLogs < ActiveRecord::Migration
  def change
    add_column :dataload_logs, :account_id, :integer
  end
end
