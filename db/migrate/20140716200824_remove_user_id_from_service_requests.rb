class RemoveUserIdFromServiceRequests < ActiveRecord::Migration
  def change
    remove_column :service_requests, :user_id
  end
end
