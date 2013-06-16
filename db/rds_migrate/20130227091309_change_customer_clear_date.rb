class ChangeCustomerClearDate < ActiveRecord::Migration
  def change
    rename_column :customers, :clear_date, :clean_date
  end
end
