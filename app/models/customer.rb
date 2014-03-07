class Customer < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  belongs_to :company
  has_one :shipping_information, dependent: :destroy
  
  accepts_nested_attributes_for :shipping_information
  
  delegate :address, :address2, :city, :state, :country, :zip_code, :address_type, to: :shipping_information
  
  validates :first_name, :contact_email, :phone_number, presence: true
  
  scope :in_company, ->(company_id) { where company_id: company_id }
  
  def full_name
    "#{first_name} #{last_name}".squish
  end
end