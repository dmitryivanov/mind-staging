#! /usr/bin/ruby

require 'logger'
require 'fileutils'
require 'net/ftp'
require 'rubygems'
require 'iconv'
require 'mysql2'
require 'roo'
require 'date'
require 'csv'
require 'active_record'
require 'activerecord-import'

file = "/Users/pierce/Documents/MarketingScienceDepartment/clients/Boa/data/All_Xcart_Orders_20120716.csv"


one_campaign = Campaign.create(
  :description  =>    "test campaign info",
  :campaign_id  =>   "1")
  

#csv = CSV.read(file, col_sep: ",", headers: false)
 
#c = Customer.new  
#csv.each do |row|
#        c.warranty_part_no = row[2],
#        c.warranty_part_desc = row[3]
#end
   

#CSV.parse(file) do |row|
#    puts row[0]
#    puts row[1]
#    puts row[5]
#    puts "#{warramty_part_no}"
#end

#File.readlines(file, "r").map do |line|
#   name, age, profession = line.strip.split(",")
#   puts name
#   puts age
#   puts profession
# end


#c = Company.new
#  FasterCSV.parse(data) do |row|
#    c.name = row[0]
#    c.street = row[1]
#    c.street_number = row[2]
#    c.apartament_number = row[3]
#    c.city = row[4]
#    c.post_code = row[5]
#    c.post_office_city = row[6]
#    c.nip = row[7]
#    c.regon = row[8]
#    c.vatin = row[9]
#  end
