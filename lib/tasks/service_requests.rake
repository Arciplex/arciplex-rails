require 'csv'

namespace :service_requests do
  task :import => :environment do
    csv = 'lib/data/arcServiceRequest.csv'
    
    CSV.foreach(csv) do |row|
      user = determine_company(row[2])
      
      puts "Using #{user.email}"
      
      customer = Customer.where(
                                  user_id: user.id,
                                  company_id: user.company_id, 
                                  prefix: row[5], 
                                  first_name: row[6], 
                                  last_name: row[7] || "",
                                  contact_email: row[18],
                                  phone_number: row[17]
                                ).first_or_initialize
      
      if customer.save
        
        shipping = ShippingInformation.where(
                                    address: row[11], 
                                    address2: row[12], 
                                    city: row[13], 
                                    state: row[14], 
                                    zip_code: row[15], 
                                    country: row[16],
                                    address_type: row[19],
                                    customer_id: customer.id,
                                  ).first_or_initialize
                                  
        if shipping.save
          ship_date = determine_default_date(row[26])
          completed_at = row[25] == "0000-00-00" ? nil : row[25]
          sr = ServiceRequest.new(
                                    customer_id: customer.id,
                                    user_id: user.id,
                                    case_number: row[1],
                                    troubleshooting_reference: row[21],
                                    rma: row[22],
                                    completed_at: completed_at,
                                    ship_date: ship_date,
                                    tracking_number: row[27],
                                    carrier: row[28],
                                    status: completed_at.nil? ? "pending" : "processed"
                                  )
                                
          sr.save
        end
      else
        puts "Customer not saved! #{customer.errors.full_messages}"
      end
    end
  end
end

def determine_company(company)
  email = {'Elan' => 'support@elanenergetics.com', 'ArciPlex' => 'julie.zaloba@arciplex.com'}.fetch(company, 'julie.zaloba@arciplex.com')
  User.find_by(email: email) rescue User.where(company_id: 2).first
end

def determine_default_date(date)
  if date == "0000-00-00"
    Time.now
  else
    date
  end
end