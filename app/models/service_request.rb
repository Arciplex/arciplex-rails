require 'securerandom'

class ServiceRequest < ActiveRecord::Base
  include AASM
  
  default_scope { order('created_at DESC') }
  
  has_many :line_items, dependent: :destroy
  belongs_to :customer
  belongs_to :user
  belongs_to :company
  has_one :note
  
  accepts_nested_attributes_for :line_items, 
    reject_if: proc { |item| item['item_type'].blank? }
    
  accepts_nested_attributes_for :note,
    reject_if: proc { |note| note['description'].blank? }
    
  validates :customer_id, :troubleshooting_reference, presence: true
  
  delegate :full_name, to: :customer
  
  before_create :generate_case_number
  
  aasm column: :status do
    state :pending, initial: true
    state :processed
  end
  
  def formatted_time(field = :created_at)
    send(:created_at).strftime("%B #{created_at.day.ordinalize}, %Y")
  end
  
  private
    def generate_case_number
      self.case_number = SecureRandom.hex(4) unless case_number.present?
    end
end