class AddTableToDashboardModules < ActiveRecord::Migration
  def change
    add_column :dashboard_modules, :table, :string
  end
end
