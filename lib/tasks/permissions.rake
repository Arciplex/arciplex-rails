namespace :permissions do
    task :create => :environment do
        u = User.find_by email: "info@vesnalight.com"
        default_perms = determine_permissions(u)

        u.companies.each do |c|
            default_perms.each do |p|
                u.permissions.create(company: c, action: p.to_s, subject_class: "ServiceRequest")
            end
        end
    end
end

def determine_permissions(user)
    case user.role
    when "client_innovator"
        [:create, :read, :approve]
    when "admin"
        [:manage]
    end
end
