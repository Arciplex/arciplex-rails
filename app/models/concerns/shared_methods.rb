module SharedMethods
  extend ActiveSupport::Concern

  included do
    belongs_to :customer
    belongs_to :user
    belongs_to :company

    accepts_nested_attributes_for :customer

    delegate :full_name, to: :customer, prefix: true
  end

  private
    def set_received_date
      self.received_at = Time.now
      save!
    end

    def set_completion_date
      self.completed_at = Time.now
      save!
    end
end
