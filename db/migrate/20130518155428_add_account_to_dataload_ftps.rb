class AddAccountToDataloadFtps < ActiveRecord::Migration
  def change
    add_column :dataload_ftps, :account_id, :integer
  end
end
