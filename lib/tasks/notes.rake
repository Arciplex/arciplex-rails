require 'csv'

namespace :notes do
  task :import => :environment do
    csv = 'lib/data/arcNotes.csv'
    CSV.foreach(csv) do |row|
      sr = ServiceRequest.find_by(case_number: row[1])
      if sr
        Note.create!(user_id: sr.user_id, service_request_id: sr.id, description: row[2])
      end
    end
  end
end