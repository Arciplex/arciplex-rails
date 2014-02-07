class CreateCustomersTable < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.references :user
      t.references :company
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :contact_email
      t.string :phone_number
      
      t.timestamps
    end
  end
end