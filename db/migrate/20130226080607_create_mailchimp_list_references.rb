class CreateMailchimpListReferences < ActiveRecord::Migration
  def change
    create_table :mailchimp_list_references do |t|
      t.integer :mailchimp_list_id
      t.integer :customer_id
    end
  end
end
