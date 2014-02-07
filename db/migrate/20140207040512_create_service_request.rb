class CreateServiceRequest < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.references :user
      t.references :customer
      
      t.string :troubleshooting_reference
      t.string :rma
      
      t.timestamps
    end
  end
end
