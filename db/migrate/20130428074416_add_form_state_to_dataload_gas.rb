class AddFormStateToDataloadGas < ActiveRecord::Migration
  def change
    add_column :dataload_gas, :form_state, :string, default: 'new'
  end
end
