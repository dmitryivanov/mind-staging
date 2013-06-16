class AddAccountToDataloadMailchimpsSourceLists < ActiveRecord::Migration
  def change
    add_column :dataload_mailchimps_source_lists, :account_id, :integer
  end
end
