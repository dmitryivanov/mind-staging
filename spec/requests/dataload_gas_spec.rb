# require 'spec_helper'
# 
# describe "when using Ga dataloads user" do
#   
#   it "displays dataloads", :vcr do
#     FactoryGirl.create(:dataload_ga)
#     
#     visit root_path
#     click_link 'google analytics'
#     
#     page.should have_content(
#       FactoryGirl.attributes_for(:dataload_ga)[:ga_username]
#     )
#   end
#   
#   it "creates dataload and proceeds to edit of credentials", :vcr do
# 
#     last_id = FactoryGirl.create(:dataload_ga).id
#     visit root_path
#     
#     click_link 'google analytics'
#     click_link "New Google Analytics Dataload"
#     fill_in "Title", with: FactoryGirl.attributes_for(:dataload_ga)[:title]
#     click_button "Create"
#     
#     URI.parse(current_url).path.should == edit_dataload_ga_path(last_id+1)
#     page.should have_content("Dataload ga was successfully created")
#     page.should have_field "Ga username", type: 'text'
#     page.should have_field "Ga password", type: 'text'
#   end
#   
#   it "enters GA dataload credentials and proceeds to next step" do
#     dataload = FactoryGirl.create(:dataload_ga)
#     visit edit_dataload_ga_path(dataload)
#     
#     fill_in "Ga username", :with => FactoryGirl.attributes_for(:dataload_ga_with_credentials)[:ga_username]
#     fill_in "Ga password", :with => FactoryGirl.attributes_for(:dataload_ga_with_credentials)[:ga_password]
#     
#     click_button "Next"
#     
#     page.should have_content("Veryfing credentials, please come back later")
#   end
#   
#   # it "allows to edit account and profile", :vcr, js: true do
#   #   resource = FactoryGirl.create(:dataload_ga)
#   #   visit edit_dataload_ga_path(resource)
#   #   
#   #   select "MarketingScienceDepartment.com", from: "Account"
#   #   select "Jason Pierce Site", from: "Profile"
#   #   # select "Visitor Type", from: "Dimension"
#   #   # select "Page Views", from: "Metric"
#   #   click_button "Update Dataload ga"
#   #   
#   #   page.should have_content("Dataload ga was successfully updated")
#   #   page.should have_select "Account", selected: "MarketingScienceDepartment.com"
#   #   page.should have_select "Profile", selected: "Jason Pierce Site"
#   #   # page.should have_select "Dimension", selected: "Visitor Type"
#   #   # page.should have_select "Metric", selected:  "Page Views"
#   #   # page.should have_select "Interval", selected:  "Page Views"
#   # end
# end
