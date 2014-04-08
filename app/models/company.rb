class Company < ActiveRecord::Base
  has_many :users
  has_many :service_requests

  scope :not_arciplex, -> { where "name != 'ArciPlex'" }

  def can_report_rma?
    name == "Elan"
  end
end