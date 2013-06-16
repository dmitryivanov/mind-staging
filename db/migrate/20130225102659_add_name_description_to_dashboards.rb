class AddNameDescriptionToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :name, :string
    add_column :dashboards, :description, :string
  end
end
