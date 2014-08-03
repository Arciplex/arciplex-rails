require 'securerandom'

class ServiceRequest < ActiveRecord::Base
  include AASM
  include SharedMethods
  include PgSearch

  default_scope { order('created_at DESC, id DESC') }

  scope :for_company, ->(company_id) { where(company_id: company_id) }

  pg_search_scope :search, associated_against: {
    customer: [:contact_email, :first_name, :last_name],
    line_items: [:serial_number]
  },
  against: :id,
  using: {
      tsearch: { prefix: true }
  }

  scope :days_ago, ->(ago) {
    where('created_at >= :days_ago', days_ago: ago)
  }

  has_many :line_items, dependent: :destroy

  has_one :note, as: :noteable, dependent: :destroy

  accepts_nested_attributes_for :line_items,
    reject_if: proc { |item| item['item_type'].blank? }, allow_destroy: true

  accepts_nested_attributes_for :note,
    reject_if: proc { |note| note['description'].blank? }

  validates_presence_of :troubleshooting_reference
  validates_associated :customer

  before_create :generate_case_number
  after_commit :notify, on: :create

  aasm column: :status do
    state :pre_approval, initial: true
    state :pending
    state :opened
    state :closed

    event :approved do
      transitions from: :pre_approval, to: :pending
    end

    event :received, after: Proc.new { set_received_date } do
      transitions from: :pending, to: :opened
    end

    event :complete, after: Proc.new { set_completion_date } do
      transitions from: [:pending, :opened], to: :closed
    end
  end

  def notify
    notify_corporate_admins
    notify_company_contacts
    notify_customer
    notify_additional_contacts
  end

  def notify_customer
    if self.company.clients_can_receive_notitifications?
      if self.company.name == "Luxana"
        ServiceRequestMailerWorker.perform_async(self.id, "warranty@elanenergetics.com")
      else
        self.company.users.pluck(:email).each do |email|
          ServiceRequestMailerWorker.perform_async(self.id, email)
        end
      end
    end
  end

  def notify_company_contacts
    ServiceRequestMailerWorker.perform_async(self.id, self.customer.contact_email) if self.customer.contact_email.present?
  end

  def notify_corporate_admins
    User.admin_and_who_receive_communication.pluck(:email).each do |email|
      ServiceRequestMailerWorker.perform_async(self.id, email)
    end
  end

  def notify_additional_contacts
    emails = self.company.additional_contacts.pluck(:email)
    emails.each do |e|
      ServiceRequestMailerWorker.perform_async(self.id, e)
    end
  end

  def set_creation_fields(source_id, source: "User")
    self.creation_identifier = source_id
    self.creation_source = source
  end

  def creator
    unless api_created?
      user = User.find(self.creation_identifier)
      user.try(:full_name)
    end
  end

  def api_created?
    self.creation_source.eql? "API"
  end

  def needs_approval?
    self.status.eql? "pre_approval"
  end

  private
    def generate_case_number
      self.case_number = SecureRandom.hex(4) unless case_number.present?
    end
end
