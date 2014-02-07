class CreateCustomerShippingInformationTable < ActiveRecord::Migration
  def change
    create_table :shipping_information do |t|
      t.references :customer
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code, limit: 10
      t.string :country
      t.string :address_type
      
      t.timestamps
    end
  end
end
