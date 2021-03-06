require 'csv'

namespace :service_requests do
  task :import => :environment do
    csv = 'lib/data/arcServiceRequest.csv'

    CSV.foreach(csv) do |row|
      user = determine_company(row[2])

      puts "Using #{user.email}"

      customer = Customer.where(
                                  prefix: row[5],
                                  first_name: row[6],
                                  last_name: row[8] || "",
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
          received_at = row[24] == "0000-00-00" ? nil : row[24]
          status = if received_at.nil?
            "pending"
          elsif received_at.present? and completed_at.present?
            "closed"
          else
            "opened"
          end

          sr = ServiceRequest.new(
                                    customer_id: customer.id,
                                    user_id: user.id,
                                    case_number: row[1],
                                    troubleshooting_reference: row[21],
                                    rma: row[22],
                                    received_at: received_at,
                                    completed_at: completed_at,
                                    created_at: row[23],
                                    ship_date: ship_date,
                                    tracking_number: row[27],
                                    carrier: row[28],
                                    status: status
                                  )

          sr.save
        end
      else
        puts "Customer not saved! #{customer.errors.full_messages}"
      end
    end
  end

  task :update_company_id => :environment do
    ServiceRequest.all.each do |sr|
      u = User.find(sr.user_id)
      sr.company_id = u.company_id
      sr.save!
    end
  end

  task :remove_45_day_old_srs => :environment do
    Rails.logger.info("Removing 45 day old SRs")
    srs = ServiceRequest.days_ago(Time.now - 45.days).pending
    srs.each { |s| s.complete! } if srs.any?
  end

  task :due_reminder => :environment do
    Rails.logger.info("Sending reminder notifications for SRs")
    srs = ServiceRequest.opened.between(12.days.ago.beginning_of_day, 12.days.ago.end_of_day)
    srs.each do |s|
      s.company.support_vendors.each do |u|
        Rails.logger.info("Sending email to #{u.email}")
        WarrantyMailer.due_notice(u.email, u.first_name, s.id).deliver!
      end
    end
  end

  task :generate_email_hashes => :environment do
     ServiceRequest.all.each do |sr|
        sr.send(:generate_hash_identifier)
        sr.save
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
