class ShippingInformation < ActiveRecord::Base
  self.table_name = "shipping_information"
  belongs_to :customer
end