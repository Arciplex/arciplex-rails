class AddCompletedAtToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :completed_at, :datetime, default: nil
  end
end
