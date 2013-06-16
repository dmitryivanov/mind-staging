def random_time(from = 1.year.ago, to = Time.now)
  Time.at(from.to_f + rand * (to.to_f - from.to_f))
end

def random_string(length = 16)
  (0...length).map{(65+rand(26)).chr}.join
end

def random_integer(max = 100)
  Random.rand(max)
end

def random_title(word_count = 3)
  Faker::Lorem.words(word_count).join(' ')
end

puts "creating default users"
User.create([
  { :email => 'robot@marketingscience.co', :password => '12345678' },
  { :email => 'ikidoit@gmail.com', :password => '12345678' }
])

puts "creatig mailchimp campaigns"
10.times.each do |i|
  created_at = random_time
  mailchimp_campaign = MailchimpCampaign.create(
    :mailchimp_id => random_string,
    :title => random_title,
    :clicks => random_integer,
    :opens => random_integer,
    :syntax_errors => random_integer,
    :hard_bounces => random_integer,
    :soft_bounces => random_integer,
    :unsubscribes => random_integer,
    :abuse_reports => random_integer,
    :forwards => random_integer,
    :forwards_opens => random_integer,
    :last_open => random_time,
    :unique_opens => random_integer,
    :unique_clicks => random_integer,
    :users_who_clicked => random_integer,
    :last_click => random_time,
    :emails_sent => random_integer,
    :unique_likes => random_integer,
    :recipient_likes => random_integer,
    :facebook_likes => random_integer,
    :created_at => created_at,
    :updated_at => random_time(created_at)
  )
  
  puts "creatig daily stats for campaign '#{mailchimp_campaign.title}'"
  created_at = random_time
  10.times do
    created_at = created_at + 1.day
    mailchimp_campaign.daily_stats.create({
      :clicks => random_integer,
      :opens => random_integer,
      :syntax_errors => random_integer,
      :hard_bounces => random_integer,
      :soft_bounces => random_integer,
      :unsubscribes => random_integer,
      :abuse_reports => random_integer,
      :forwards => random_integer,
      :forwards_opens => random_integer,
      :last_open => random_time,
      :unique_opens => random_integer,
      :unique_clicks => random_integer,
      :users_who_clicked => random_integer,
      :last_click => random_time,
      :emails_sent => random_integer,
      :unique_likes => random_integer,
      :recipient_likes => random_integer,
      :facebook_likes => random_integer,
      :created_at => created_at,
      :updated_at => created_at
    })
  end
end

# predefined list of activities
puts "creating activities"
activities = Faker::Lorem.words(10).map {|w| Activity.find_or_create_by_name(w)}

puts "creating customers"
200.times.each do |i|  

  # create customer
  created_at = random_time
  subscribe_date = random_time
  email_subscription_states = Customer.state_machines[:email_subscription_state].states.map(&:name)
  email_permission_states = Customer.state_machines[:email_permission_state].states.map(&:name)
  customer = Customer.create(
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :billing_addr_ln1 => Faker::Address.street_address,
    :billing_addr_ln2 => Faker::Address.secondary_address,
    :billing_addr_city => Faker::Address.city,
    :billing_addr_state => Faker::Address.state,
    :billing_addr_zip => Faker::Address.zip,
    :shipping_addr_ln1 => Faker::Address.street_address,
    :shipping_addr_ln2 => Faker::Address.secondary_address,
    :shipping_addr_city => Faker::Address.city,
    :shipping_addr_state => Faker::Address.state,
    :shipping_addr_zip => Faker::Address.zip,
    :phone_number => Faker::PhoneNumber.cell_phone,
    :email_addr => Faker::Internet.email,
    :updated_at => random_time(created_at),
    :foreign_id => random_integer,
    :subscribe_date => subscribe_date,
    :unsubscribe_date => random_time(subscribe_date),
    :clean_date => random_time(subscribe_date),
    :email_subscription_state => email_subscription_states[rand(email_subscription_states.size)],
    :email_permission_state => email_permission_states[rand(email_permission_states.size)],
    :created_at => created_at
  )
  
  # add activities to customer
  puts "adding activities to customer ##{i} '#{customer.first_name} #{customer.last_name}'"
  customer.activities = [activities[rand(10)], activities[rand(10)]]
  
  # add customer warranties
  puts "adding customer warranties to customer ##{i} '#{customer.first_name} #{customer.last_name}'"
  3.times do |j|
    created_at = random_time
    customer.customer_warranties.create({
      :warranty_part_no => random_integer,
      :warranty_part_desc => Faker::Lorem.word,
      :length_lace_pack => Faker::Lorem.word,
      :warranty_order => random_time,
      :created_at => created_at,
      :updated_at => random_time(created_at),
      :warranty_order_date => random_time
    })
  end
  
  customer.save
  
=begin
  TODO: add customer facts if needed

  3.times do
    created_at = random_time
    customer.customer_facts.create({
      t.string   "customer_id"
      t.string   "customer_warranty_id"
      t.datetime "created_at",           :null => false
      t.datetime "updated_at",           :null => false
    })
  end
=end
  
end