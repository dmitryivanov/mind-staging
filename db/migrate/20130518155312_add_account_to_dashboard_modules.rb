class AddAccountToDashboardModules < ActiveRecord::Migration
  def change
    add_column :dashboard_modules, :account_id, :integer
  end
end
