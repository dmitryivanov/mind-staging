class CreateDataloadMailchimpsSourceLists < ActiveRecord::Migration
  def up
    create_table :dataload_mailchimps_source_lists, :id => false do |t|
      t.references :dataload_mailchimp
      t.references :source_list
    end
    
    add_index :dataload_mailchimps_source_lists, 
      [:dataload_mailchimp_id, :source_list_id], 
      :name => 'index_dload_mc_source_lists_on_dload_mc_id_and_src_list_id'
      
    add_index :dataload_mailchimps_source_lists, 
      [:source_list_id, :dataload_mailchimp_id],
      :name => 'index_dload_mc_source_lists_on_src_list_id_and_dload_mc_id'
  end

  def down
    drop_table :dataload_mailchimps_source_lists
  end
end
