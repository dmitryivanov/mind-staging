class AddAccountToDataloadEmails < ActiveRecord::Migration
  def change
    add_column :dataload_emails, :account_id, :integer
  end
end
