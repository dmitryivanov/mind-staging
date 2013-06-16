require 'spec_helper'

# TODO: 
#   * test that campaign update correctly starts from a rake task
#   * when guard is restarded, it keeps running all specs as before
#   * rspec do not sees dailty stats relations, probably due to using multiple dbs
#   * rspec is not clearing all databases, only default one
#   * is suspect that continuos integration tools also will not support multiple databases

describe CmpUpdateWorker do

  let(:dataload_mailchimp) { FactoryGirl.create(:dataload_mailchimp) }
  let(:dataload_log) { FactoryGirl.create(:dataload_log) }
  let(:gibbon) { Gibbon.new }
  
  let(:campaign) do
     { 'id' => '123', 'title' => 'some_title' } 
  end
  
  let(:worker) { CmpUpdateWorker.new }
  
  let(:daily_stats) do
    daily_stats = mock(Object)
    daily_stats.stub(:build).and_return(daily_stat)
  end
  
  let(:daily_stat) do
    daily_stat = FactoryGirl.build(:daily_stat)
    daily_stat.stub(:calculate_delta_for_stats!)
  end
  
  let(:mailchimp_campaign) do 
    mailchimp_campaign = FactoryGirl.create(:mailchimp_campaign)
    mailchimp_campaign.stub(:datily_stats).and_return(daily_stats)
    mailchimp_campaign
  end
  
  # lives in supports/mock_helpers 
  # adds a let(:stats) with stats hash
  mock_stats

  describe "perform" do
    it "retrieves dataload", :vcr do
      DataloadMailchimp.should_receive(:find).with(dataload_mailchimp.id).and_return(dataload_mailchimp)
      worker.perform(dataload_mailchimp.id)
    end
    
    it "runs do_with_rescue_and_logging method with a block", :vcr do
      worker.should_receive(:do_with_rescue_and_logging).and_yield.and_return(dataload_log)      
      worker.perform(dataload_mailchimp.id)
    end
    
    it "retrives campaigns", :vcr do
      gibbon.stub(:lists)
      Gibbon.should_receive(:new).any_number_of_times.and_return(gibbon)
      gibbon.should_receive(:campaigns)
      worker.perform(dataload_mailchimp.id)
    end
    
    it "retrieves only sent campaigns" do
      gibbon.stub(:lists)
      Gibbon.should_receive(:new).any_number_of_times.and_return(gibbon)
      gibbon.should_receive(:campaigns) { |args|
        args.should include(:filters => {:status => 'sent'})
      }        
      worker.perform(dataload_mailchimp.id)
    end
    
    
    it "retrieves more than 100 campaigns and creates or updates them" do
      gibbon.stub(:lists)
      Gibbon.should_receive(:new).any_number_of_times.and_return(gibbon)
      gibbon.stub(:campaigns) do 
        campaigns = []
        200.times {|i| campaigns << { 'title' => "campaign #{i}" } }
        { 'total' => 200, 'data' => campaigns }
      end
      
      gibbon.should_receive(:campaigns).twice
      worker.should_receive(:save_campaign_stats).exactly(200).times
      worker.perform(dataload_mailchimp.id)
    end
      
    it "creates or updates stats for each campaign withot 'test' in name" do
      gibbon.stub(:lists)
      Gibbon.should_receive(:new).any_number_of_times.and_return(gibbon)
      gibbon.stub(:campaigns) do 
        { 'data' => [ 
          { 'title' => "test campaign" }, 
          { 'title' => "regular campaign" } 
        ] }
      end

      worker.should_receive(:save_campaign_stats).once.with({ 'title' => "regular campaign" } )
      worker.perform(dataload_mailchimp.id)
    end

    it "updates cmp_update_last_runned_at for dataload after finishing", :vcr do
      DataloadMailchimp.should_receive(:find).and_return(dataload_mailchimp)
      worker.should_receive(:do_with_rescue_and_logging).and_return(dataload_log)
      dataload_mailchimp.should_receive(:update_attributes) do |arguments|
        arguments.should include(:cmp_update_last_runned_at )
      end
      worker.perform(dataload_mailchimp.id)
    end
  end
  
  describe "attributes_from_stats" do
    
    before do
      worker.instance_variable_set :@gibbon, gibbon 
    end
    
    it "retrieves campaign stats" do           
      gibbon.should_receive(:campaign_stats).and_return({})
      worker.attributes_from_stats(campaign)    
    end
    
    it "rejects invalid campaign stats" do
      invalid_stats = stats.stringify_keys.merge({ 'blah' => 123 })
      gibbon.should_receive(:campaign_stats).and_return(invalid_stats)
      result = worker.attributes_from_stats(campaign)
      result.should_not include('blah')
    end
    
    it "returns stats hash with mailchimp campaign id and title" do
      gibbon.should_receive(:campaign_stats).
        and_return(stats.stringify_keys)
        
      result = worker.attributes_from_stats(campaign)
      result.should eq(stats.merge({ 
        mailchimp_id: campaign['id'],
        title: campaign['title']
      }))
    end

  end    
  
  describe "save_campaign_stats" do
    
    it "calls attributes_from_stats with retrieved campaign"
  
    it "finds or init campaign by mailchimp id"
      
      
    context "when mailchimp campaign not found" do
      it "creates mailchimp campaign"
      it "does not create daily stats"      
      it "logs error when cannot create mailchimp campaign"      
      it "logs success when creates mailchimp campaign"
    end
  
    context "when mailchimp campaign found" do
      it "creates daily stat with delta stats"      
      it "logs error when can't create daily stat"      
      it "logs success when creates daily stat" 

      it "updates mailchimp campaign with stats summary"
      it "logs error when can't update mailchimp campaign"
      it "logs success when updates mailchimp campaign"
    end
  end
  
end