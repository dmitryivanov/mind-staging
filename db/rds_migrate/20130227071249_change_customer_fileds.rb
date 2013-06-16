class ChangeCustomerFileds < ActiveRecord::Migration
  def up
    remove_column :customers, :sent_to_mailchimp
    remove_column :customers, :subscriber_ind
    remove_column :customers, :email_permission_ind
    
    add_column :customers, :email_subscription_state, :string
    add_column :customers, :email_permission_state, :string
  end
  
  def down    
    add_column :customers, :sent_to_mailchimp, :boolean
    add_column :customers, :subscriber_ind, :boolean
    add_column :customers, :email_permission_ind, :boolean
    
    remove_column :customers, :email_subscription_state
    remove_column :customers, :email_permission_state
  end
end
