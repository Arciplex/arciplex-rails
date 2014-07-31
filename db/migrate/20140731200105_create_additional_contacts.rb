class CreateAdditionalContacts < ActiveRecord::Migration
  def change
    create_table :additional_contacts do |t|
      t.string :email
      t.references :company, index: true

      t.timestamps
    end
  end
end
