class AddForeignIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :foreign_id, :integer
  end
end
