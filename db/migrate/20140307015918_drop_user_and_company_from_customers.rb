class DropUserAndCompanyFromCustomers < ActiveRecord::Migration
  def change
  	remove_column :customers, :user_id
  	remove_column :customers, :company_id
  end
end
