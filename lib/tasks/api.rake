namespace :api do

  task :migrate_user_id_to_new_format => :environment do
    srs = ServiceRequest.all
    srs.each do |sr|
      sr.update_attributes(creation_source: "User", creation_identifier: sr.user_id)
    end
  end

end
