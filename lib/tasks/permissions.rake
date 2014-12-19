namespace :permissions do
    task :create => :environment do
        u = User.where(role: "client_innovator")

        u.each do |u|
            default_perms = determine_permissions(u)
            u.companies.each do |c|
                default_perms.each do |p|
                    u.permissions.create(company: c, action: p.to_s, subject_class: "ServiceRequest")
                end
            end

            custom_permissions.each do |k, v|
                u.permissions.create(action: k.to_s, custom_subject: v.to_s)
            end
        end
    end
end

def determine_permissions(user)
    perms = [:create, :read]

    case user.role
    when "client_innovator"
        perms.concat [:approve]
    when "admin"
        perms.concat [:update, :delete, :approve]
    end
end

def custom_permissions
    {
        :read => :user_guides
    }
end
