class GaCredentialsValidatior
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
  def perform(dataload_id)
    
  end
end