class AddEmailHashIdentifierToServiceRequests < ActiveRecord::Migration
  def change
      add_column :service_requests, :email_hash_identifier, :string
  end
end
