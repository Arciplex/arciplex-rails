class ChangeNotesToBePolymorphic < ActiveRecord::Migration
  def change
    rename_column :notes, :service_request_id, :noteable_id
    add_column :notes, :noteable_type, :string

    ::Note.all.each do |note|
      note.update_attribute(:noteable_type, "ServiceRequest")
    end
  end
end
