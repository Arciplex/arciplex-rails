require 'securerandom'

class ServiceRequest < ActiveRecord::Base
  include AASM
  
  has_many :line_items, dependent: :destroy
  belongs_to :customer
  
  accepts_nested_attributes_for :line_items, 
    reject_if: proc { |item| item['item_type'].blank? }
    
  validates :customer_id, :troubleshooting_reference, presence: true
  
  delegate :full_name, to: :customer
  
  before_create :generate_case_number
  
  aasm column: :status do
    state :pending, initial: true
    state :processed
  end
  
  private
    def generate_case_number
      self.case_number = SecureRandom.hex(4)
    end
end