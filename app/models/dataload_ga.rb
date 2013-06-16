class DataloadGa < ActiveRecord::Base
  attr_accessible :ga_password, :ga_username, :title,
    :dimension, :metric, :interval # to be created
    
  validates :title, presence: true
  
  state_machine :form_state, :initial => :new do
   
    state :credentials

    state :verifying_credentials do
      validates :ga_username, presence: true
      validates :ga_password, presence: true
    end
    
    after_transition :credentials => :verifying_credentials, :do => :schedule_credentials_validation
    
    event :next_step do
      transition :credentials => :verifying_credentials
    end
  end
  
  before_create :set_form_state_to_credentials

private
  
  def set_form_state_to_credentials
    self.form_state = 'credentials'
  end
  
  def schedule_credentials_validation    
    GaCredentialsValidatior.perform_async(self.id)
  end
    
#   validate :ga_credentials_valid?
#   
#   def ga_credentials_valid?    
#     begin
#       Garb::Session.login(ga_username, ga_password)
#     rescue Garb::AuthError
#       errors.add(:base, "Google Analytics credentials are not valid")
#       return false
#     end
#     
#     return true
#   end
#   
#   def accounts
#     ga_data.accounts
#   end
#   
#   def profiles
#     ga_data.profiles
#   end
#   
# private
#   
#   def ga_data
#     unless @ga_data
#       @ga_data = nil
#       
#       if ga_credentials_valid?
#         @ga_data = Hashie::Mash.new({
#           accounts: Garb::Management::Account.all,
#           profiles: Garb::Management::Profile.all
#         }) 
#       end
#     end
#     
#     return @ga_data
#   end
    
end
