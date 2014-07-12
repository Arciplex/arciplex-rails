class AddCanCreateOrdersToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :can_manage_orders, :boolean, default: false
  end
end
