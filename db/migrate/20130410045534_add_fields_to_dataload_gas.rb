class AddFieldsToDataloadGas < ActiveRecord::Migration
  def change
    add_column :dataload_gas, :ga_account_id, :integer
    add_column :dataload_gas, :ga_profile_id, :integer
    add_column :dataload_gas, :dimension, :string
    add_column :dataload_gas, :metric, :string
    add_column :dataload_gas, :update_interval, :string
  end
end
