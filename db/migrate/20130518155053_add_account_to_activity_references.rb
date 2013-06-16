class AddAccountToActivityReferences < ActiveRecord::Migration
  def change
    add_column :activity_references, :account_id, :integer
  end
end
