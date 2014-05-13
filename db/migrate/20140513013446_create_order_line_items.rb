class CreateOrderLineItems < ActiveRecord::Migration
  def change
    create_table :order_line_items do |t|
      t.references :order

      t.string :item
      t.string :quantity
      t.text :additional_information

      t.timestamps

    end
  end
end
