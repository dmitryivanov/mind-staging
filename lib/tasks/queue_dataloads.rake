namespace :dataloads do
  task :queue => :environment do
    DataloadMailchimp.all.each do |d|
      d.queue_dataloads_if_needed
    end
  end
end