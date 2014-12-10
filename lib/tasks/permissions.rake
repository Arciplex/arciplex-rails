namespace :permissions do
    task :create => :environment do
        u = User.find_by email: "tom.haarlander@arciplex.com"
        companies = Company.all

        companies.each do |c|
            ['ServiceRequest', 'Order'].each do |sc|
                u.permissions.create(company: c, action: "manage", subject_class: sc)
            end
        end
    end
end
