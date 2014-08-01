class AddActivationIdAndWarrantyVoidToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :activation_id, :text
    add_column :line_items, :warranty_void, :text
  end
end
