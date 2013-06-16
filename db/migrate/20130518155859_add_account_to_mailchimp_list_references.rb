class AddAccountToMailchimpListReferences < ActiveRecord::Migration
  def change
    add_column :mailchimp_list_references, :account_id, :integer
  end
end
