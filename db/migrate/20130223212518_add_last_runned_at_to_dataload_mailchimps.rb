class AddLastRunnedAtToDataloadMailchimps < ActiveRecord::Migration
  def change
    add_column :dataload_mailchimps, :last_runned_at, :datetime
  end
end
