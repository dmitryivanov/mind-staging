class AddAccountToDataloads < ActiveRecord::Migration
  def change
    add_column :dataloads, :account_id, :integer
  end
end
