class AddCompanyIdToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :company_id, :integer
  end
end
