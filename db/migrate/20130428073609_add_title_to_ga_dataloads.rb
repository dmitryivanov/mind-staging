class AddTitleToGaDataloads < ActiveRecord::Migration
  def change
    add_column :dataload_gas, :title, :string
  end
end
