class AddAdditionalInformationToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :additional_information, :text, default: nil
  end
end
