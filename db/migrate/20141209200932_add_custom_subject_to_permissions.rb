class AddCustomSubjectToPermissions < ActiveRecord::Migration
  def change
      add_column :permissions, :custom_subject, :string
  end
end
