namespace :companies do
  task :add_new => :environment do
    ["Vivid", "EnerChi"].each do |company|
      Company.create!(name: company)
    end
  end
end