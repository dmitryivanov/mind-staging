namespace :db do
  task :wipe_tables => :environment do
    puts "Recreating mailchimp dataload"
    DataloadMailchimp.destroy_all

    puts "Destroying mailchimp lists"
    MailchimpList.destroy_all

    puts "Destroying manual dataloads"
    DataloadManual.destroy_all

    puts "Destroying dataload logs"
    DataloadLog.destroy_all

    puts "Destroying customers"
    Customer.destroy_all
  end
end
