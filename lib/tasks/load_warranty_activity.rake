desc "test task"
     namespace :import do
     task :csv_file => :environment do
      csv = CSV.read(file, col_sep: ",", headers: false)

       c = Customer.new  
       csv.each do |row|
        c.warranty_part_no = row[2],
        c.warranty_part_desc = row[3]
       end
       c.save
      end
    end
