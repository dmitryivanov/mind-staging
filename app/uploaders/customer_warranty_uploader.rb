class CustomerWarrantyUploader < CarrierWave::Uploader::Base

  storage :fog
  # storage :file
  def store_dir
    "data/dataloads_manual/#{model.id}/"
  end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
   %w(csv)
  end

end
