class CreateDataloadMailchimpsDestinationLists < ActiveRecord::Migration
  def up
    create_table :dataload_mailchimps_destination_lists, :id => false do |t|
      t.references :dataload_mailchimp
      t.references :destination_list
    end
    
    add_index :dataload_mailchimps_destination_lists, 
      [:dataload_mailchimp_id, :destination_list_id], 
      :name => 'index_dload_mc_destination_lists_on_dload_mc_id_and_dst_list_id'
      
    add_index :dataload_mailchimps_destination_lists, 
      [:destination_list_id, :dataload_mailchimp_id],
      :name => 'index_dload_mc_destination_lists_on_dst_list_id_and_dload_mc_id'
  end

  def down
    drop_table :dataload_mailchimps_destination_lists
  end
end
