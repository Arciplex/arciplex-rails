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

  task :import_client_logins => :environment do
    csv = 'lib/data/arcClientLogins.csv'

    CSV.foreach(csv) do |row|
      company = Company.find_by_name(row[0])
      User.create!({
        email: row[1],
        password: row[2],
        password_confirmation: row[2],
        receives_communication: row[3],
        company_id: company.id
      })
    end
  end

  task :import_corporate_logins => :environment do
    csv = 'lib/data/arcNewCorporateLogins.csv'

    CSV.foreach(csv) do |row|
      company = Company.find_by_name("ArciPlex")
      User.create!({
        first_name: row[0],
        last_name: row[1],
        email: row[2],
        password: row[2],
        password_confirmation: row[2],
        role: row[4],
        receives_communication: row[5],
        company_id: company.id
      })
    end
  end

  task :change_to_many_companies => :environment do
    users = User.all
    companies = Company.all

    users.each do |u|
      if u.admin?
        u.companies << companies
      elsif u.has_role?(:shipping_vendor)
        u.companies << [Company.find_by(name: "Elan"), Company.find_by(name: "Vivid"), Company.find_by(name: "EnerChi"), Company.find_by(name: "Luxana"), Company.find_by(name: "Luxana")]
      else
        u.companies << Company.find(u.company_id)
      end
    end

  end

end
