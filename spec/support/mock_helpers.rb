module MockHelpers
  def mock_dataload_ga
    let(:accounts) {[ 
      double(
        Garb::Management::Account, 
          :id => 11, 
          :name => 'Account 1'
      ),    
      double(
        Garb::Management::Account, 
          :id => 12, 
          :name => 'Account 2'
      ) 
    ]}

    let(:profiles) {[ 
      double(
        Garb::Management::Profile, 
          :id => 21, 
          :name => 'Profile 1', 
          :account_id => accounts.first.id
      ),
      double(
        Garb::Management::Profile, 
          :id => 21, 
          :name => 'Profile 2', 
          :account_id => accounts.second.id
      ) 
    ]}
    
    let(:dataload_ga) do
      dataload_ga = FactoryGirl.build_stubbed(:dataload_ga)
      dataload_ga.stub(:accounts).and_return(accounts)
      dataload_ga.stub(:profiles).and_return(profiles)  
      dataload_ga = DataloadGaDecorator.new(dataload_ga)
    end

  end
  
  def mock_stats
    let(:stats) { 
      {
        :syntax_errors => 1,
        :hard_bounces => 1,
        :soft_bounces => 1,
        :unsubscribes => 1,
        :abuse_reports => 1,
        :forwards => 1,
        :forwards_opens => 1,
        :opens => 1,
        :last_open => 1,
        :unique_opens => 1,
        :clicks => 1,
        :unique_clicks => 1,
        :users_who_clicked => 1,
        :last_click => 1,
        :emails_sent => 1,
        :unique_likes => 1,
        :recipient_likes => 1,
        :facebook_likes => 1
      }
    }
  end
end