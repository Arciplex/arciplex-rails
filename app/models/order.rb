class Order < ActiveRecord::Base
  include AASM
  include SharedMethods
  include PgSearch

  default_scope { order('created_at DESC, id DESC') }

  belongs_to :user

  has_many :order_line_items, dependent: :destroy
  has_one :note, as: :noteable, dependent: :destroy

  accepts_nested_attributes_for :order_line_items,
    reject_if: proc { |item| item['item'].blank? }

  pg_search_scope :search, associated_against: {
    customer: [:contact_email, :first_name, :last_name],
    order_line_items: [:serial_number]
  },
  against: :id,
  using: {
      tsearch: { prefix: true }
  }

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

end
