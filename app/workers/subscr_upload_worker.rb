# Worker to upload customers from our database to mailchimp
# e.g. subscribe them to all destination lists
#
class SubscrUploadWorker < BaseWorker
  
  #
  # Main sidekiq worker method
  #
  # dataload_id (integer) - id of DataloadMailchimp
  #
  def perform(dataload_id)
    start_time = Time.now
    @dataload = DataloadMailchimp.find(dataload_id)
    @gibbon = Gibbon.new(@dataload.api_key)
    
    @dataload.destination_lists.each do |list|
    
      options = {
        :dataload_type => "mailchimp subscriber upload to list '#{list.name}'"
      }
    
      # do_with_rescue_and_logging - wrapper method on
      # parent BoaWorker class
      dataload_log = do_with_rescue_and_logging(options) do
      
        customers = get_customers_to_upload(list)
        log "Sending new customers to list '#{list.name}'"
        
        
        # TODO: change status after subscribing!!
        # email_subscription_state = subscribed
        # e.g. get emails that had no errors
        # and update them all!!
        
        
        customers.find_in_batches(:batch_size => 1000) do |batch|
          
          result = subscribe_batch_to_list(batch, list)
          
          # there can be errors and successfully added users at
          # the same time
          if result[:error_count].to_i > 0
            increment_success_count_by(result[:add_count])
            result[:errors].each do |error|
              log "#{error['code']}: Error subscribing #{error['email']} to list #{list.name}", :error, error['message']
            end
          else
            increment_success_count_by(result[:add_count])
            log "Successfully subscribed #{result[:add_count]} customers"
          end
          
        end # end of customers.find_in_batches
        
      end # end of do_with_rescue_and_logging
      
      list.update_attributes(
        :subscr_upload_last_runned_at => dataload_log.created_at
      )
      
    end # end of @dataload.destination_lists.each
    
    @dataload.update_attributes(
      :subscr_upload_last_runned_at => start_time
    )     
  end
  
  # get customer with appropriate subscription
  # and email permission_states, and changed or
  # added since last run of worker
  #
  # list (object) - DataloadMailchimp
  #
  def get_customers_to_upload(list)    
    
    # if list name is not 'get dialed in' we expect users to give us permissions,
    # but we send to 'get dialed in' even those whe haven't been aske
    customers = Customer.where(
      :email_subscription_state => :not_subscribed,
      :email_permission_state => (list.name.downcase.to_s == 'get dialed in' ? :not_asked : :granted)
    )
    
    unless list.subscr_upload_last_runned_at.blank? or Rails.env.development?
      customers = customers.where(
        'customers.created_at > ?', list.subscr_upload_last_runned_at
      )
    end

    log "There are #{customers.count} customers to subscribe"

    return customers
  end
  

  #
  # prepare array of customers and send them
  # to mailchimp
  #
  # batch (object/array) - batch returned from AR.find_in_batches
  # list (object) - MailchimpList
  #
  # returns result from gibbon.list_batch_subscribe
  #
  def subscribe_batch_to_list(batch, list)
    prepared_batch = batch.map do |customer|
      { 
        :EMAIL => customer.email_addr, 
        :EMAIL_TYPE => 'html', 
        :FNAME => customer.first_name, 
        :LNAME => customer.last_name
      }
    end

    result = @gibbon.list_batch_subscribe(
      :id => list.list_id, 
      :batch => prepared_batch,
      :double_optin => false
    ).symbolize_keys
    
    return result
  end
  
end