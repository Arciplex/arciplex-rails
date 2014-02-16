class CreateNoteTable < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :service_request, null: false
      t.references :user, null: false
      t.text :description, default: ""
      
      t.timestamps
    end
  end
end
