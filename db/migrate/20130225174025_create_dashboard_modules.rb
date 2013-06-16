class CreateDashboardModules < ActiveRecord::Migration
  def change
    create_table :dashboard_modules do |t|
      t.references :dashboard
      t.string :module_type
      t.text :notes

      t.timestamps
    end
  end
end
