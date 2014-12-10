class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
        t.references :user, index: true
        t.references :company, index: true

        t.string :action
        t.string :subject_class

        t.timestamps
    end
  end
end
