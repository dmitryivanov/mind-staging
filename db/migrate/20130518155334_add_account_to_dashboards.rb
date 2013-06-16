class AddAccountToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :account_id, :integer
  end
end
