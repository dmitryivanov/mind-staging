class AddAccountToDataloadMailchimps < ActiveRecord::Migration
  def change
    add_column :dataload_mailchimps, :account_id, :integer
  end
end
