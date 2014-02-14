class ShippingInformation < ActiveRecord::Base
  self.table_name = "shipping_information"
  belongs_to :customer, dependent: :destroy
  
  validates :customer_id, :address, :city, :state, :zip_code, :country, :address_type, presence: true
end