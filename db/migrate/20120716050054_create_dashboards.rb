class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :dashboard_id
      t.string :module
      t.string :source_system

      t.timestamps
    end
  end
end
