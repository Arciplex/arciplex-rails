class LineItem < ActiveRecord::Base
  belongs_to :service_request
end