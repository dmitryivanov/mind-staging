class CreateMailchimpLists < ActiveRecord::Migration
  def change
    create_table :mailchimp_lists do |t|
      t.string :list_id

      t.timestamps
    end
  end
end
