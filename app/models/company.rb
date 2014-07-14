class Company < ActiveRecord::Base
  has_many :users, through: :company_users
  has_many :companies_users
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
    self.can_manage_orders?
  end
end
