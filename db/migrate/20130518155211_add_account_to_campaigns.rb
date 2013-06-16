class AddAccountToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :account_id, :integer
  end
end
