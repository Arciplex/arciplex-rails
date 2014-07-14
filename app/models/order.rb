class Order < ActiveRecord::Base
  include AASM
  include SharedMethods

  has_many :order_line_items, dependent: :destroy
  has_one :note, as: :noteable, dependent: :destroy

  accepts_nested_attributes_for :order_line_items,
    reject_if: proc { |item| item['item'].blank? }

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
