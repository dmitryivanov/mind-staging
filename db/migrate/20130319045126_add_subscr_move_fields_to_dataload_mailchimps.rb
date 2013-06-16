class AddSubscrMoveFieldsToDataloadMailchimps < ActiveRecord::Migration
  def change
    add_column :dataload_mailchimps, :subscr_move_enabled, :boolean
    add_column :dataload_mailchimps, :subscr_move_interval, :string
    add_column :dataload_mailchimps, :subscr_move_last_runned_at, :datetime
  end
end
