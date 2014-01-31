require 'csv'

namespace :users do
  task :import => :environment do
    csv = 'lib/data/arcLogin.csv'
    
    CSV.foreach(csv) do |row|
      name = row[3].split(" ")
      company = Company.find_or_create_by(name: row[4])
      
      User.create!({
        email: row[1],
        first_name: name.first || "",
        last_name: name.last || "",
        password: row[2],
        password_confirmation: row[2],
        company_id: company.id
      })
    end
  end
end