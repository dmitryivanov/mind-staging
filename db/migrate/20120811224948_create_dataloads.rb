class CreateDataloads < ActiveRecord::Migration
  def change
    create_table :dataloads do |t|
        t.string :source
        t.string :succcess_ind
        t.string :error_msg
        t.string :rows_loaded
        t.string :request_user
        t.string :file_name
        
      t.timestamps
    end
  end
end
