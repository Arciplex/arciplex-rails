require 'securerandom'

class ServiceRequest < ActiveRecord::Base
  include AASM
  
  default_scope { where('company_id IS NOT NULL').order('created_at DESC') }

  scope :for_company, ->(company_id) { where(company_id: company_id) }
  
  has_many :line_items, dependent: :destroy
  belongs_to :customer
  belongs_to :user
  belongs_to :company
  has_one :note
  
  accepts_nested_attributes_for :line_items, 
    reject_if: proc { |item| item['item_type'].blank? }
    
  accepts_nested_attributes_for :note,
    reject_if: proc { |note| note['description'].blank? }

  accepts_nested_attributes_for :customer
    
  validates :troubleshooting_reference, presence: true
  
  delegate :full_name, to: :customer
  
  before_create :generate_case_number
  
  aasm column: :status do
    state :pending, initial: true
    
    event :received, after: Proc.new { set_received_date } do
      transitions from: :pending, to: :opened
    end

    state :opened
    
    event :close do
      transitions from: :pending, to: :closed
    end
    
    state :closed
  end
  
  def formatted_time(field = :created_at)
    send(field).strftime("%B #{send(field).day.ordinalize}, %Y")
  end

  def notify
    User.admin_and_who_receive_communication.pluck(:email).each do |email|
      WarrantyMailer.submitted(self, self.customer, email).deliver
    end
  end
  
  private
    def generate_case_number
      self.case_number = SecureRandom.hex(4) unless case_number.present?
    end
    
    def set_received_date
      self.received_at = Time.now
      save!
    end
end