class AddCsvImportedToDataloadManuals < ActiveRecord::Migration
  def change
    add_column :dataload_manuals, :csv_imported, :boolean
  end
end
