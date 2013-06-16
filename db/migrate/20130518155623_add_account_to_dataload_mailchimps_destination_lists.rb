class AddAccountToDataloadMailchimpsDestinationLists < ActiveRecord::Migration
  def change
    add_column :dataload_mailchimps_destination_lists, :account_id, :integer
  end
end
