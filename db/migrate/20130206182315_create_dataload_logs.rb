class CreateDataloadLogs < ActiveRecord::Migration
  def change
    create_table :dataload_logs do |t|
      t.string :dataload_type
      t.boolean :is_successfull
      t.integer :success_rows
      t.integer :error_rows
      t.text :error_text

      t.timestamps
    end
  end
end
