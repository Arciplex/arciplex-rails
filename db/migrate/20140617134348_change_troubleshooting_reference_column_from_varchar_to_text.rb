class ChangeTroubleshootingReferenceColumnFromVarcharToText < ActiveRecord::Migration
  def up
    change_column :service_requests, :troubleshooting_reference, :text
  end

  def down
    change_column :service_requests, :troubleshooting_reference, :string
  end
end
