class AddDataloadToDataloadManual < ActiveRecord::Migration
  def change
    add_column :dataload_manuals, :dataload, :string
  end
end
