class LineItem < ActiveRecord::Base
  belongs_to :service_request

  validates_presence_of :serial_number
end
