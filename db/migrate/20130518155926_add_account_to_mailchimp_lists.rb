class AddAccountToMailchimpLists < ActiveRecord::Migration
  def change
    add_column :mailchimp_lists, :account_id, :integer
  end
end
