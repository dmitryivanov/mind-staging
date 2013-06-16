# This worker downloads customers from mailchimp and
# adds them to database, and also marks unsubscribed and cleaned
# customers who are already in db

class SubscrDownloadWorker < BaseWorker
  
  #
  # Main sidekiq worker method
  #
  # dataload_id (integer) - id of DataloadMailchimp
  #
  def perform(dataload_id)
    start_time = Time.now
    @dataload = DataloadMailchimp.find(dataload_id)
    @gibbon = Gibbon.new(@dataload.api_key)
    
    @dataload.source_lists.each do |list|
      options = {
        :dataload_type => "mailchimp subscriber download from list '#{list.name}'"
      }
      
      # do_with_rescue_and_logging - wrapper method on
      # parent BoaWorker class
      dataload_log = do_with_rescue_and_logging(options) do    
        download_and_save_subsribed_for_list(list)
        get_and_mark_for_list(list, :status => 'unsubscribed')
        get_and_mark_for_list(list, :status => 'cleaned')
      end
      
      list.update_attributes(
        :subscr_download_last_runned_at => dataload_log.created_at
      )
    end
    
    @dataload.update_attributes(
      :subscr_download_last_runned_at => start_time
    )
  end


  #
  # Add new customers to database, if customer is there then do nothing
  #
  # list (object) - MailchimpList
  #
  def download_and_save_subsribed_for_list(list)
    members = get_list_members(
      :status => 'subscribed', 
      :list => list,
      :since => list.subscr_download_last_runned_at
    )

    filter_members_not_in_db(members).each do |members|
      customer = Customer.new(
        :email_addr => members[:email],
        :email_subscription_state => :subscribed,
        :email_permission_state => :granted,
        :subscribe_date => members[:confirm_time],
        :activities => get_activities_ids(members[:activities])   
      )
      
      if customer.save
        log "Added '#{customer.email_addr}' to database", :success
        
        # record lists that customer belongs to
        unless customer.mailchimp_lists.include?(list)
          customer.mailchimp_lists << list 
          customer.save
        end
      else
        log "Cannot save '#{customer.email_addr}' to database", :error, customer.errors.inspect
      end
    end
  end

  #
  # mark customers in db to their corresponding
  # status on mailchimp (clears/unsubscribed)
  # and set set subscription and email permission states
  #
  # list (object) - MailchimpList
  #
  # options hash:
  #   :status (string) - valid mailchimp list, defaults to 'subscibed'
  
  def get_and_mark_for_list(list, options = {})
    
    members = get_list_members(
      :status => options[:status], 
      :list => list, 
      :since => list.subscr_download_last_runned_at
    )
    
    members.each do |member|
      customer = Customer.find_by_email_addr(member[:email])
      if customer
        
        new_attributes = case options[:status]
          when 'unsubscribed'
            {
              :unsubscribe_date => member[:unsub_time],
              :email_subscription_state => :unsubscribed,
              :email_permission_state => :denied
            }

          when 'cleared'
            {
              :clean_date => member[:clean_time],
              :email_subscription_state => :cleaned,
              :email_permission_state => :denied
            }
        end
          
        if customer.update_attributes(new_attributes)
          log "Updated '#{member[:email]}' as '#{options[:status]}'", :success
        else
          log "Error updating '#{member[:email]}' as '#{options[:status]}' from list '#{list.name}'", 
            :error, customer.error.inspect
        end
        
      else
        log "Customer '#{member[:email]}' not found in db"
      end
    end      
  end
  
  
  # loads members from mailchimp, expects hash of options
  #
  # Options hash
  # :status (string) - valid mailchimp status, set as 'subscribed' by default
  # :list (object) 
  # :since (datetime) - time for getting delta from mailchimp

  def get_list_members(options = {})
    list = options[:list]
    log "Loading members from MailChimp for list '#{list.name}' with status '#{options[:status]}'"  

    @gibbon_export ||= @gibbon.get_exporter
    
    parameters = { 
      :id => list.list_id, 
      :status => (options[:status] || 'subscribed') 
    }
    
    unless options[:since].blank? or Rails.env.development?
      parameters[:since] = options[:since].strftime('%Y-%m-%d %H:%M:%S')
    end

    rows = @gibbon_export.list(parameters)

    indexes = {}
    members = []

    # Check batch of emails if they are in db
    rows.each_with_index do |row, i| 
      row = ActiveSupport::JSON.decode(row)
      
      # we get members as plain rows from mailchimp,
      # header row allows us to map indexes to symbol keys
      if i == 0
        indexes[:email] = row.index('Email Address')
        indexes[:confirm_time] = row.index('CONFIRM_TIME')
        indexes[:unsub_time] = row.index('UNSUB_TIME')
        indexes[:clean_time] = row.index('CLEAN_TIME')
        indexes[:activities] = row.index('Activities')
        next
      end

      # download only 10 customers on development
      if i == 11 and Rails.env.development?
        break
      end

      # create named hash insead of meaningless array    
      member = {}
      indexes.each do |name, index|
        member[name] = row[index] unless index.nil?
      end
      members << member
    end

    log "Got #{members.count} subscribers with status '#{options[:status]}' from list"

    return members
  end
  

  #
  # Check if given emails are recorded as customers in our db
  #
  # Accepts members hash from get_list_members method, at least with :email key to filter by
  # Returns array of members hashes, not found in db
  #
  def filter_members_not_in_db(members)
    found_members = []
    members.each_slice(100) do |members_slice|
      result = Customer.where(:email_addr => members.map{|m|m[:email]}).select(:email_addr).map(&:email_addr)
      found_members.concat(members_slice.select {|m| result.include?(m[:email]) })
    end
    not_found_members = members - found_members

    log "#{not_found_members.count} subscribers are not in database"
    not_found_members
  end
  
  
  # Get ids of activites from comma-separated
  # string as we get it from mailchimp
  #
  # activities (string) - comma-separated list of activities
  #
  def get_activities_ids(activities_list)
    activities = []

    if activities_list
      activities_list.split(',').each do |name|
        activity = Activity.find_or_create_by_name(name.strip)
        activities << activity
      end
    end

    return activities
  end
end