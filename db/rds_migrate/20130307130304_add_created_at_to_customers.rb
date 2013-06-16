class AddCreatedAtToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :created_at, :datetime
  end
end
