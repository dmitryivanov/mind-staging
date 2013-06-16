class AddUserIdToDataloadManuals < ActiveRecord::Migration
  def change
    add_column :dataload_manuals, :user_id, :integer
  end
end
