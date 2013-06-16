# Worker to download campaign stats from mailchimp
# for all campaigns that do not have 'test' in title
# for given mailchimp account

class CmpUpdateWorker < BaseWorker
  #
  # Main sidekiq worker method
  #
  # dataload_id (integer) - id of DataloadMailchimp
  #
  def perform(dataload_id)
    @dataload = DataloadMailchimp.find(dataload_id)
    @gibbon = Gibbon.new(@dataload.api_key)
    
    options = {
      :dataload_type => "mailchimp campaign stats update"
    }
    
    # do_with_rescue_and_logging - wrapper method on
    # parent BoaWorker class
    dataload_log = do_with_rescue_and_logging(options) do
      
      # campaigns(string apikey, array filters, int start, int limit)
      # http://apidocs.mailchimp.com/api/1.3/campaigns.func.php
      # Get the list of campaigns and their details matching the specified filters
      #
      # by default campaigns() returns 25 records per page,
      # so we run this part in a lopp until we get all of them
      #
      
      start = 0
      limit = 100
      begin
        
        # Campaign stats are not available until the campaign 
        # has been completely sent, so we filrer by status
        campaigns = @gibbon.campaigns(
          :start => start, 
          :limit => limit, 
          :filters => {:status => 'sent'}
        )

        # reject campaigns which have 'test' in their title
        # and update stats for the rest  
        campaigns['data'].reject {|c| c['title'] =~ /test/i}.each do |c|
          save_campaign_stats(c)
        end

        start += limit

      end while campaigns['total'] > limit

    end
  
    @dataload.update_attributes(
      :cmp_update_last_runned_at => dataload_log.created_at
    )
  end
  
  
  
  def save_campaign_stats(c)
    
    campaign_data = attributes_from_stats(c)
    
    campaign = MailchimpCampaign.find_or_initialize_by_mailchimp_id(
      campaign_data
    )
     
    if campaign.new_record?
      
      if campaign.save
        log "Created campaign '#{campaign.title}'", :success
      else
        log "Failed to create campaign '#{campaign.title}': #{campaign.errors}", :error
      end
       
    else
       
      daily_stats = campaign.daily_stats.build
      daily_stats.calculate_delta_for_stats!(campaign_data)
      
      if daily_stats.save
        log "Saved campaign stats for '#{campaign.title}'", :success
      else
        log "Failed to save campaign stats for '#{campaign.title}': #{daily_stats.errors}", :error
      end
       
      if campaign.update_attributes(campaign_data)
        log "Updated campaign '#{campaign.title}'", :success
      else
        log "Failed to update campaign '#{campaign.title}': #{campaign.errors}", :error
      end
       
    end
  end
  
  
   
  def attributes_from_stats(c)
    # campaignStats(string apikey, string cid)
    # http://apidocs.mailchimp.com/api/1.3/campaignstats.func.php
    # Given a list and a campaign, get all the relevant campaign statistics (opens, bounces, clicks, etc.)

    # leave only stats mapped to our database and add campaign id and title
    
    campaign_data = @gibbon.campaign_stats(:cid => c['id']).symbolize_keys!

    campaign_data.reject! {|c,v| !VALID_MC_CAMPAIGN_STATS.include?(c)}

    campaign_data.merge!({
      :mailchimp_id => c['id'],
      :title => c['title']
    })

    return campaign_data
  end
 
     
end