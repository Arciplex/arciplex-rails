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
    state :opened
    state :closed
    
    event :received, after: Proc.new { set_received_date } do
      transitions from: :pending, to: :opened
    end
    
    event :complete, after: Proc.new { set_completion_date } do
      transitions from: :opened, to: :closed
    end
  end
  
  def formatted_time(field = :created_at)
    send(field).strftime("%B #{send(field).day.ordinalize}, %Y")
  end

  def notify
    notify_corporate_admins
    notify_company_contacts
    notify_customer
  end

  def notify_customer
    if self.company.clients_can_receive_notitifications?
      if self.company.name == "Luxana"
        WarrantyMailer.submitted(self, self.customer, "warranty@elanenergetics.com").deliver
      else
        self.company.users.pluck(:email).each do |email|
          WarrantyMailer.submitted(self, self.customer, email).deliver
        end
      end
    end
  end

  def notify_company_contacts
    WarrantyMailer.submitted(self, self.customer, self.customer.contact_email).deliver if self.customer.contact_email.present?
  end

  def notify_corporate_admins
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

    def set_completion_date
      self.completed_at = Time.now
      save!
    end
end