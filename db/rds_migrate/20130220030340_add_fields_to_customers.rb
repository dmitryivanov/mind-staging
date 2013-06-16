class AddFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :subscriber_ind, :boolean
    add_column :customers, :email_permission_ind, :boolean
    add_column :customers, :sent_to_mailchimp, :boolean
  end
end
