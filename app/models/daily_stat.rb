class DailyStat < ActiveRecord::RdsDb
  belongs_to :mailchimp_campaign
  
  def calculate_delta_for_stats(campaign_data)
    campaign = mailchimp_campaign

    delta_values = {}
    campaign_data.each do |key, value|
      next unless VALID_MC_CAMPAIGN_STATS.include?(key)
      delta = value.to_i - (campaign.send(key).nil? ? 0 : campaign.send(key).to_i)
      delta_values[key] = delta
    end
    
    return delta_values
  end
  
  def calculate_delta_for_stats!(campaign_data)
    result_values = calculate_delta_for_stats(campaign_data)
    result_values.each do |key, value|
      send("#{key.to_s}=", value)
    end
  end
end
