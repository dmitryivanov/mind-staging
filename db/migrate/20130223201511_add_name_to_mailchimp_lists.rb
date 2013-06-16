class AddNameToMailchimpLists < ActiveRecord::Migration
  def change
    add_column :mailchimp_lists, :name, :string
  end
end
