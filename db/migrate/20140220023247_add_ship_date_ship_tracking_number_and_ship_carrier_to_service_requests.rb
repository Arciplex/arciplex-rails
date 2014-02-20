class AddShipDateShipTrackingNumberAndShipCarrierToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :ship_date, :datetime, default: nil
    add_column :service_requests, :tracking_number, :text, default: nil
    add_column :service_requests, :carrier, :text, default: nil
  end
end
