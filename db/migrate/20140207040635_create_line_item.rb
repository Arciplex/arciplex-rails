class CreateLineItem < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :service_request
      
      t.string :item_type
      t.string :model_number
      t.string :serial_number
      
      t.timestamps
    end
  end
end
