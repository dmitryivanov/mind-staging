require 'spec_helper'

describe DailyStat do
  
  it "connects to rds database" do
    DailyStat.connection.class.name.should eq('ActiveRecord::ConnectionAdapters::Mysql2Adapter')
  end    
  
  mock_stats
    
  let(:current_daily_stat) do
    FactoryGirl.build(:daily_stat,  mailchimp_campaign_id: 10)
  end
     
           
  let(:previous_daily_stat) do  
   FactoryGirl.create :daily_stat, stats.merge({ mailchimp_campaign_id: 10 })
  end
  
  context "assign_calculated_stat_delta" do
    subject do
      # increment each value in a hash
      campaign_data = Hash[stats.map{ |k,s| [k,s+1] }]    
      current_daily_stat.assign_calculated_stat_delta(campaign_data)
    end
    
    it "assigns delta"
      # syntax_errors.should_eq 1
      # :hard_bounces => 1,
      # :soft_bounces => 1,
      # :unsubscribes => 1,
      # :abuse_reports => 1,
      # :forwards => 1,
      # :forwards_opens => 1,
      # :opens => 1,
      # :last_open => 1,
      # :unique_opens => 1,
      # :clicks => 1,
      # :unique_clicks => 1,
      # :users_who_clicked => 1,
      # :last_click => 1,
      # :emails_sent => 1,
      # :unique_likes => 1,
      # :recipient_likes => 1,
      # :facebook_likes => 1
  
    it "ignores invalid stats"
  end
  
end