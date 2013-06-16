class AddFieldsToDataloadMailchimps < ActiveRecord::Migration
  def change
    rename_column :dataload_mailchimps, :last_runned_at, :cmp_update_last_runned_at
    rename_column :dataload_mailchimps, :subscr_update_enabled, :subscr_upload_enabled
    rename_column :dataload_mailchimps, :subscr_update_interval, :subscr_upload_interval
    
    add_column :dataload_mailchimps, :subscr_upload_last_runned_at, :datetime  
    add_column :dataload_mailchimps, :subscr_download_enabled, :boolean
    add_column :dataload_mailchimps, :subscr_download_interval, :string
    add_column :dataload_mailchimps, :subscr_download_last_runned_at, :datetime
  end
end
