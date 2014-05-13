class AddSerialNumberToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :serial_number, :text
  end
end
