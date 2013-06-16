class AddFieldsToMailchimpLists < ActiveRecord::Migration
  def change
    add_column :mailchimp_lists, :subscr_upload_last_runned_at, :datetime  
    add_column :mailchimp_lists, :subscr_download_last_runned_at, :datetime
  end
end
