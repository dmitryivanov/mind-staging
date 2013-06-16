class AddAccountToMailchimpCampaigns < ActiveRecord::Migration
  def change
    add_column :mailchimp_campaigns, :account_id, :integer
  end
end
