require 'spec_helper'

# describe "global GA constants" do
#   it "are defined" do
#     Object.const_defined?('GA_METRICS').should be_true
#     Object.const_defined?('GA_DIMENSIONS').should be_true
#   end
#   
#   it "are not empty" do
#     GA_METRICS.empty?.should be_false
#     GA_DIMENSIONS.empty?.should be_false
#   end
# end

describe DataloadGa do
  
  it "has a valid factory", :vcr do
    FactoryGirl.build(:dataload_ga).should be_valid
  end
  
  it { should validate_presence_of(:title) }
  
  it "form state is 'new' when new record" do
    FactoryGirl.build(:dataload_ga).form_state.should == 'new'    
  end
  
  it "sets form state to 'credentials' when model is created" do
    FactoryGirl.create(:dataload_ga).form_state.should == 'credentials'
  end
  
  context "next_step event" do
    
    context "on transition to verifying_credentials form_state" do      

      context "when ga_username or ga_password blank" do
        
        let(:dataload_ga) { FactoryGirl.create(:dataload_ga) }
        
        subject { dataload_ga.next_step }
        
        it "fails to transition" do
          dataload_ga.form_state.should == 'credentials'
        end
        
        it "returns false" do
          subject.should be_false
        end
        
        it "sets model's errors" do
          dataload_ga.next_step
          dataload_ga.errors.should_not be_empty
        end
      end
      
      context "when ga_username and ga_password not blank" do
        
        let(:dataload_ga) { FactoryGirl.create(:dataload_ga_with_credentials) }
        
        it "transitions successfully" do
          dataload_ga.next_step
          dataload_ga.form_state.should == 'verifying_credentials'
        end
        
        it "returns true" do 
          dataload_ga.next_step.should be_true
        end

        it "starts background job to validate credentials"
        
      end

    end
    
  end


  # it "is valid with valid GA username and password", :vcr do
  #   FactoryGirl.build(:dataload_ga).should be_valid
  # end
  
  # it "is invalid with invalid GA username and password", :vcr do
  #   FactoryGirl.build(:dataload_ga, ga_username: 'Dummy username').should_not be_valid
  # end
  
  # describe "ga_credentials_valid? method" do
  #   
  #   it "returns true for valid ga credentials", :vcr do
  #     resource = FactoryGirl.build(:dataload_ga)
  #     resource.ga_credentials_valid? .should be_true
  #   end
  # 
  #   it "returns false for invalid ga credentials", :vcr do
  #     resource =FactoryGirl.build(:dataload_ga, ga_username: 'Dummy username')
  #     resource.ga_credentials_valid?.should be_false
  #   end
  #   
  # end
  # 
  # it "returns accounts", :vcr do
  #   accounts = FactoryGirl.build(:dataload_ga).accounts
  #   accounts.count.should eql(2)
  #   accounts.first.class.name.should eql('Garb::Management::Account')
  #   accounts.first.name.should eql('MarketingScienceDepartment.com')
  #   accounts.first.id.should eql('1445323')
  # end
  # 
  # it "returns profiles", :vcr do
  #   profiles = FactoryGirl.build(:dataload_ga).profiles
  #   profiles.count.should eql(2)
  #   
  #   first_profile = profiles.first
  #   first_profile.class.name.should eql('Garb::Management::Profile')
  #   first_profile.name.should eql('MarketingScience.co')
  #   first_profile.id.should eql('16550641')
  #   first_profile.website_url.should eql('http://www.marketingsciencedepartment.com')
  # end

end