require 'csv'

namespace :line_items do
  task :import => :environment do
    csv = "lib/data/arcServiceRequestLines.csv"
    
    CSV.foreach(csv) do |row|
      req = ServiceRequest.find_by(case_number: row[1])
      
      if req
        req.line_items.create!(item_type: row[2], model_number: row[3], serial_number: row[4])
      end
    end
  end
end