#
# Parses csv and creates customers and customer warranties
# 

require 'csv'

class DataloadManualImportWorker < BaseWorker
  
  #
  # Main sidekiq worker method
  #
  # dataload_id (integer) - id of DataloadMailchimp
  #
  def perform(dataload_id)
    @dataload = DataloadManual.find(dataload_id)
    
    options = {
      :dataload_type => "manual dataload",
      :user_id => @dataload.user.id
    }
    
    # do_with_rescue_and_logging - wrapper method on
    # parent BoaWorker class
    do_with_rescue_and_logging(options) do
    
      # cannot pass dataload.read directly to CSV.parse, crashes on heroku
      file_contents = @dataload.dataload.read
      CSV.parse(file_contents) do |row|
        
        attributes = get_customer_attributes_from_row(row)
        customer = Customer.find_or_initialize_by_email_addr(attributes)
      
        if customer.new_record?
          
          if customer.save
            log "Added customer '#{customer.email_addr}'"
            add_customer_fact_and_warranty(row, customer)
          else
            log "Cannot save customer '#{customer.email_addr}'", :error, customer.errors.inspect
          end
          
        else
          
          # Even if customer exists, create customer warranty for him
          add_customer_fact_and_warranty(row, customer)
        
        end # if customer.new_record?
      
      # end of CSV.parse
      end 
    
    # end of do_with_rescue_and_logging
    end
    
    @dataload.csv_imported = true
    unless @dataload.save
      log "Cannot save dataload #{@dataload.id}", :error, @dataload.errors.inspect
    end
  end
  
  #
  # Maps data from csv row to hash values
  #
  # row (array) - row as read from csv
  #
  def get_customer_attributes_from_row(row)
    attributes = {
      :foreign_id => row[0], # create
      :first_name => row[26],
      :last_name => row[27],
      :billing_addr_ln1 => row[32],
      :billing_addr_ln2 => row[33],
      :billing_addr_city => row[34],
      :billing_addr_state => row[35],
      :billing_addr_cc => row[36],
      :billing_addr_zip => row[37],
      :shipping_addr_ln1 => row[41],
      :shipping_addr_ln2 => row[42],
      :shipping_addr_city => row[43],
      :shipping_addr_state => row[44],
      :shipping_addr_cc => row[45],
      :shipping_addr_zip => row[46],
      :phone_number =>  row[47],
      :email_addr => row[50]
    }
    
    return attributes
  end

  #
  # Maps data from csv row to hash values and creates customer warranty
  #
  # row (array) - row as read from csv
  # customer (object) - Customer
  #  
  def add_customer_fact_and_warranty(row, customer)
    
    attributes = {
      :warranty_part_no => row[2],
      :warranty_part_desc => row[3],
      :length_lace_pack => row[4],
      :warranty_order => row[1],
      :warranty_order_date => DateTime.strptime('10.08.09 22:11', '%d.%m.%Y %H:%M')
    }
    
    warranty = customer.customer_warranties.build(attributes)

    if warranty.save
      log "Added warranty for '#{customer.email_addr}'", :success
    else
      log "Cannot save customer warranty for '#{customer.email_addr}'", :error,  warranty.errors.inspect
    end
    
    unless warranty.new_record?
      customer_fact = CustomerFact.new(
        :customer_id => customer.id,
        :warranty_id => warranty.id
      )
      
      if customer_fact.save
        log "Added customer fact for '#{customer.email_addr}'", :success
      else
        log "Cannot save customer fact for '#{customer.email_addr}'", :error,  customer_fact.errors.inspect
      end
    end
  end
end
