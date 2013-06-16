class DataloadMailchimp < ActiveRecord::Base
  validate :mailchimp_api_key_valid?
  
  DATALOAD_TYPES = ['subscr_upload', 'subscr_download', 'subscr_move', 'cmp_update']
  INTERVALS = ['Daily', 'Weekly', 'Monthly']
  
  attr_accessible :api_key, :source_list_ids, :destination_list_ids
  
  DATALOAD_TYPES.each do |dataload_type|
    ['enabled', 'interval', 'last_runned_at']. each do |attribute|
      attr_accessible [dataload_type, attribute].join('_').to_sym
    end
  end
      
    
  has_and_belongs_to_many :source_lists, 
    :class_name => 'MailchimpList', 
    :join_table => 'dataload_mailchimps_source_lists',
    :association_foreign_key => 'source_list_id'
    
  has_and_belongs_to_many :destination_lists, 
    :class_name => 'MailchimpList', 
    :join_table => 'dataload_mailchimps_destination_lists',
    :association_foreign_key => 'destination_list_id'
  
  def queue_dataloads_if_needed
    DATALOAD_TYPES.each do |dataload_type|
      if time_to_run_dataload?(dataload_type)
        logger.info "---------- Starting #{dataload_type.camelize}Worker"
        "#{dataload_type.camelize}Worker".constantize.send('perform_async', self.id)
      end
    end
  end
  
  def time_to_run_dataload?(dataload_type)
    return false unless self.send("#{dataload_type}_enabled?")
    its_time_to_run = false
    
    if self.send("#{dataload_type}_last_runned_at").blank? or Rails.env.development?
      its_time_to_run = true
    else
      method = case self.send("#{dataload_type}_interval")
        when 'Daily' then :day
        when 'Weekly' then :week
        when 'Monthly' then :month
      end
      
      its_time_to_run = self.send("#{dataload_type}_last_runned_at").send(method) != Date.today.send(method)
    end
      
    return its_time_to_run
  end
  
  def mailchimp_api_key_valid?
    gibbon = Gibbon.new(api_key)
    begin
      gibbon.lists
    rescue Gibbon::MailChimpError
      errors.add(:api_key, "is not valid")
    end
  end
end
