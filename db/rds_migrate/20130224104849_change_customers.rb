class ChangeCustomers < ActiveRecord::Migration
  def change
    change_column :customers, :sent_to_mailchimp, :boolean, :default => false
  end
end
