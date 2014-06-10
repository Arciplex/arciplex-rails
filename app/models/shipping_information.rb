class ShippingInformation < ActiveRecord::Base
  self.table_name = "shipping_information"
  belongs_to :customer, dependent: :destroy

  validates_presence_of :address, :city, :state, :zip_code, :country,
                        :address_type
end
