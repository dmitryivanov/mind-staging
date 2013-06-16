class ChangeDataloadMailchmpFields < ActiveRecord::Migration
  def up
    drop_table :dataload_mailchimps
    create_table :dataload_mailchimps do |t|
      t.references :user
      t.string :api_key
      t.boolean :subscr_update_enabled
      t.string :subscr_update_interval
      t.boolean :cmp_update_enabled
      t.string :cmp_update_interval
      
      t.timestamps
    end
  end

  def down
    drop_table :dataload_mailchimps
    create_table :dataload_mailchimps do |t|
      t.string :/
      t.string :file_name
      t.string :request_user
      t.string :success_ind
      t.string :table_name
      t.string :mc_username
      t.string :mc_password
      t.string :campaigns
      t.string :metrics
      t.string :schedule

      t.timestamps
    end
  end
end
