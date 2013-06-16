class DataloadManual < ActiveRecord::Base
  attr_accessible :dataload, :file_name, :request_user, :s3_id, :success_ind, :table_name
  mount_uploader :dataload, CustomerWarrantyUploader
  belongs_to :user
  
  # TODO:
  # customer has_many customer_warranties
  # customer_warranty belongs_to customer
  
  def perform_import
    DataloadManualImportWorker.perform_async(self.id) unless csv_imported?
  end
end
