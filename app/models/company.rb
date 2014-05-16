class Company < ActiveRecord::Base
  has_many :users
  has_many :service_requests
  has_many :orders

  scope :not_arciplex, -> { where "name != ?", 'ArciPlex' }

  def can_report_rma?
    name == "Elan"
  end

  def clients_can_receive_notitifications?
    name != "Elan"
  end

  def can_make_orders?
    ['Vivid', 'Luxana', 'Vesna'].include? self.name
  end
end
