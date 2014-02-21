class AddReceivedAtToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :received_at, :datetime
  end
end
