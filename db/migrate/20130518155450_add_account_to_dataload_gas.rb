class AddAccountToDataloadGas < ActiveRecord::Migration
  def change
    add_column :dataload_gas, :account_id, :integer
  end
end
