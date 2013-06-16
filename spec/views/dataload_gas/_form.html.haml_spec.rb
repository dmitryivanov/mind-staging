require "spec_helper"

describe "dataload_gas/_form.html.haml" do
  
  context "when new object" do
  
    before do
      assign :dataload_ga, FactoryGirl.build(:dataload_ga)
      render
    end

    it "displays create button" do
      rendered.should have_button('Create')
    end
    
    it "renders correct partial" do
      rendered.should render_template(:partial => '_form_new')
    end
  
    #   
    # it "not displays accounts and profiles selectors" do
    #   rendered.should_not have_selector('input#dataload_ga_ga_account_id')
    #   rendered.should_not have_selector('input#dataload_ga_ga_profile_id')
    # end

  end
  
  context "when existing resource" do
    
    before(:each) do
      assign :dataload_ga, FactoryGirl.build_stubbed(:dataload_ga)
      render
    end
    
    it "displays next button" do
      rendered.should have_button('Next')
    end    
    
    it "displays cancel button" do
      rendered.should have_button('Cancel')
    end
    
  end
    
  context "when editing credentials" do
    
    before(:each) do
      assign :dataload_ga, FactoryGirl.build_stubbed(
        :dataload_ga_with_credentials, 
        form_state: 'credentials'
      )
      render
    end
    
    it "renders correct partial" do
      rendered.should render_template(:partial => '_form_credentials')
    end
  
    it "displays credentials inputs" do
      rendered.should have_selector('input#dataload_ga_ga_username')
      rendered.should have_selector('input#dataload_ga_ga_password')
    end
    
  end
  
  #   
  #   mock_dataload_ga
  #   
  #   before do
  #     assign :dataload_ga, dataload_ga  
  #     render
  #   end
  # 
  #   it "renders accounts selector" do
  #     rendered.should have_xpath "//select[@id = 'dataload_ga_ga_account_id']/option[@value = '#{accounts.first.id}']"
  #   end
  # 
  #   it "renders hidden profile selectors in a container" do
  #     rendered.should have_xpath "
  #     //div[@class='profile_container' and @rel='#{accounts.first.id}' and @style='display:none']
  #     /select[@class='profile_selector' and @rel='#{accounts.first.id}']
  #     /option[@value='#{profiles.first.id}']"      
  #   end
  #   
  # end
end
