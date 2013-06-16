class AddDimensionValueToDashboardModules < ActiveRecord::Migration
  def change
    add_column :dashboard_modules, :dimension_value, :string
    add_column :dashboard_modules, :date, :string
  end
end
