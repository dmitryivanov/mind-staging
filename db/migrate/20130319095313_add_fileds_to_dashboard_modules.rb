class AddFiledsToDashboardModules < ActiveRecord::Migration
  def change
    add_column :dashboard_modules, :dimension, :string  
    add_column :dashboard_modules, :metric, :string
  end
end
