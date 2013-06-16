require 'spec_helper'

describe 'Devise Authentication' do
  it 'logging in and logging out' do
    user = FactoryGirl.create(:user)

    visit root_path
    page.should have_content('Please login below.')

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'log in'

    page.should have_content("logged in as #{user.email}")
    page.should have_content('log out')

    click_link 'log out'
    page.should have_content('logged out')
    page.should have_content('Please login below.')
  end
end
