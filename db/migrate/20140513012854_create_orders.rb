class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :company
      t.references :customer
      t.datetime :received_at, default: nil
      t.datetime :ship_date, default: nil
      t.string :status
      t.string :tracking_number
      t.string :carrier

      t.timestamps
    end
  end
end
