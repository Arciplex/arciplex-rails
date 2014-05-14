class AddCompanyNameToShippingInformation < ActiveRecord::Migration
  def change
    add_column :shipping_information, :company_name, :text, default: nil
  end
end
