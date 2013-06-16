# require 'spec_helper'
#  
# describe DataloadGaDecorator do
#   
#   mock_dataload_ga
#   
#   context "hidden_profile_select_for_account", :draper_with_helpers do
#     
#     let(:account) { dataload_ga.accounts.first }
#     
#     subject do
#       dataload_ga.hidden_profile_select_for_account(account) 
#     end
#     
#     it { should have_selector("div.profile_container", :rel => account.id, :style => 'display:none') }
#     it { should have_selector("div.profile_container select.profile_selector", :rel => account.id ) }
#     it { should have_selector("div.profile_container select.profile_selector", :rel => account.id ) }
#     it { should_not have_selector("div.profile_container select#profile_selector") }
# 
#     it "returns profies for account as selector options" do
#       profiles.each do |profile|
#         subject.should have_selector(
#           "select.profile_selector option", 
#           :value => profile.id, 
#           :content => profile.name
#         )
#       end
#     end
#     
#   end
# end