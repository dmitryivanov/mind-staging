#if Rails.env.staging? || Rails.env.production?
  CarrierWave.configure do |config|
    #config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['BOA_AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['BOA_AWS_SECRET_ACCESS_KEY']
    }

    config.fog_directory  = 'lucifer-boa' # required
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    config.cache_dir      = "#{Rails.root}/tmp/uploads"
  end
# else
#   CarrierWave.configure do |config|
#     config.storage = :file
#   end
# end
