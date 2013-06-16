class Dataload < ActiveRecord::Base
    
    attr_accessible :file_name, :request_user, :source
    
    validates_presence_of :file
    
    mount_uploader :file, CustomerWarrantyUploader
    
end
