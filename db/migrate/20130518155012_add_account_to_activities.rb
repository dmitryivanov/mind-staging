class AddAccountToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :account_id, :integer
  end
end
