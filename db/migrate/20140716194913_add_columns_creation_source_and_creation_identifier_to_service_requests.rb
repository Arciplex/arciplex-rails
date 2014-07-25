class AddColumnsCreationSourceAndCreationIdentifierToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :creation_source, :string
    add_column :service_requests, :creation_identifier, :string
  end
end
