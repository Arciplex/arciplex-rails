class ServiceRequest < ActiveRecord::Base
  include AASM
  
  has_many :line_items, dependent: :destroy
  
  aasm column: :status do
    state :pending, initial: true
    state :processed
  end
end