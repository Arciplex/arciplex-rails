namespace :companies do
  task :add_new => :environment do
    ["Vivid", "EnerChi"].each do |company|
      Company.create!(name: company)
    end
  end

  task :generate_api_keys => :environment do
    companies = Company.all

    companies.each do |c|
      key = SecureRandom.hex(32)
      c.api_keys << ApiKey.new(access_token: key, active: true)
    end
  end
end
