# Worker to move customers from get dialed in to
# monthly newsletter
#
class SubscrMoveWorker < BaseWorker
  
  #
  # Main sidekiq worker method
  #
  # dataload_id (integer) - id of DataloadMailchimp
  #
  def perform(dataload_id)
    start_time = Time.now
    @dataload = DataloadMailchimp.find(dataload_id)
    @gibbon = Gibbon.new(@dataload.api_key)
    @gibbon_export ||= @gibbon.get_exporter
    
    source_list_name = 'get dialed in'
    destination_list_name = 'monthly newsletter'
    source_list_grouping_name = 'customers'
    source_list_group_name = 'confirmed_subs'
        
    options = {
      :dataload_type => "mailchimp subscriber moving from 'get dialed in' to 'monthly newsletter'"
    }
    
    # do_with_rescue_and_logging - wrapper method on
    # parent BoaWorker class
    dataload_log = do_with_rescue_and_logging(options) do
      
      error = false
      
      # get soruce and destination lists
      lists = @gibbon.lists['data']      
      source_list = lists.find { |l| l['name'].downcase.to_s == source_list_name }      
      destination_list = lists.find { |l| l['name'].downcase.to_s == destination_list_name }
      
      
      
      # log and exit if one of the lists was not found
      if source_list.nil?
        log "Cannot find list named '#{source_list_name}'", :error
        error = true
      elsif destination_list.nil?
        log "Cannot find list named '#{destination_list_name}'", :error
        error = true
      end
        
       
      # find grouping named Customers on source list
      unless error
        groupings = @gibbon.list_interest_groupings(:id => source_list['id'])
        source_list_grouping = groupings.find {|g| g['name'].downcase.to_s == source_list_grouping_name }

        # log and exit if grouping was not found
        if source_list_grouping.nil?
          log "Cannot find grouping named '#{source_list_grouping_name}' in '#{source_list_name}' list", :error
          error = true
        end
      end
      
      
      
      # get people to move, which are in source list group
      unless error
        subscribers_to_move = @gibbon_export.list(
          :id => source_list['id'], 
          :segment => {
            :match => 'all', 
            :conditions => [{
              :field => "interests-#{source_list_grouping['id']}", 
              :op => 'one', 
              :value => source_list_group_name
            }]
          }
        )      
      
        # subscribe them to destination list
        prepared_batch = normalize_exported_subscribers(subscribers_to_move)
        subscribe_result = @gibbon.list_batch_subscribe(
          :id => destination_list['id'], 
          :batch => prepared_batch,
          :double_optin => false
        ).symbolize_keys
      
        # 214 - already subscribed to list, skip those errors
        errors = subscribe_result[:errors].reject { |e| e['code'] == 214 } 
        if subscribe_result[:error_count].to_i > 0 and errors.size > 0
          increment_success_count_by(subscribe_result[:add_count])        
          errors.each do |error|
            log "#{error['code']}: Error subscribing #{error['email']} to list #{destination_list['name']}", :error, error['message']
          end
        else
          increment_success_count_by(subscribe_result[:add_count])
          log "Successfully subscribed #{subscribe_result[:add_count]} customers to list '#{destination_list['name']}'"
        end
      end     
    end
    
    @dataload.update_attributes(
      :subscr_upload_last_runned_at => start_time
    )     
  end
  
  def normalize_exported_subscribers(rows)
    header = []
    prepared_subscribers = []

    # Check batch of emails if they are in db
    rows.each_with_index do |row, i| 
      row = ActiveSupport::JSON.decode(row)
      
      # we get members as plain rows from mailchimp,
      # header row allows us to map indexes to symbol keys
      if i == 0
        header = row
        header[0] = 'EMAIL'
        next
      end

      # download only 10 customers on development
      if i == 11 and Rails.env.development?
        break
      end

      # create named hash insead of meaningless array    
      member = {}
      header.each_with_index do |field_name, index|
        member[field_name] = row[index]
      end

      prepared_subscribers << member
    end
    
    return prepared_subscribers
  end
end