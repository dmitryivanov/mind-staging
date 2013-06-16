class AddCalculationTypeToDashboardModules < ActiveRecord::Migration
  def change
    add_column :dashboard_modules, :calculation_type, :string
  end
end
