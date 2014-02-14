class AddCaseNumberToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :case_number, :string, limit: 8, null: false
  end
end
