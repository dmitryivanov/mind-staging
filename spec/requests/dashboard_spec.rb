require 'spec_helper'

describe "when viewing dashboard" do
  let(:dashboard) { FactoryGirl.create(:dashboard) }
  let(:user) { FactoryGirl.create(:user) }
    
  it "can create module", js: true do
    visit login_path
    fill_in 'email_', with: user.email
    fill_in 'password', with: user.password
    click_button 'log in'
    page.should have_content('logged in')
      
    visit dashboard_path(dashboard.id)
    page.should have_css('#dashboard .details')
    click_button 'Add module'
    page.all('div').should == '123'
    page.all('.module').size.should == 1
  end
  
end
