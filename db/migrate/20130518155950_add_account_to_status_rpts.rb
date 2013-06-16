class AddAccountToStatusRpts < ActiveRecord::Migration
  def change
    add_column :status_rpts, :account_id, :integer
  end
end
