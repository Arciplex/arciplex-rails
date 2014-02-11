class ServiceRequest < ActiveRecord::Base
  include AASM
  
  has_many :line_items, dependent: :destroy
  belongs_to :customer
  
  accepts_nested_attributes_for :line_items, 
    reject_if: proc { |item| item['item_type'].blank? }
  
  aasm column: :status do
    state :pending, initial: true
    state :processed
  end
end