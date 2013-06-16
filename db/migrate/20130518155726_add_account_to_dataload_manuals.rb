class AddAccountToDataloadManuals < ActiveRecord::Migration
  def change
    add_column :dataload_manuals, :account_id, :integer
  end
end
