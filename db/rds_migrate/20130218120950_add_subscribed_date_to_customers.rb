class AddSubscribedDateToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :subscribe_date, :date
    add_column :customers, :unsubscribe_date, :date
    add_column :customers, :clear_date, :date
  end
end
