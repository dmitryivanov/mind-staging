FactoryGirl.define do
  factory :dashboard do |f|
    f.name "test dashboard"
  end
  
  factory :user do |f|
    f.email "robot@marketingscience.com"
    f.password '12345678'
  end
  
  factory :dataload_mailchimp do |f|
    f.api_key ENV['MAILCHIMP_API_KEY']
  end

  factory :dataload_ga do |f|
    f.title 'Test dataload'
    
    factory :dataload_ga_with_credentials do |c|
      c.ga_username ENV['GA_USERNAME']
      c.ga_password ENV['GA_PASSWORD']
    end
  end

  factory :mailchimp_campaign
  factory :daily_stat
  factory :dataload_log

  factory :user do
    email    { Faker::Internet.email }
    password 'topsecret'
  end
end


