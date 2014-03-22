class AddAdditionalInformationToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :additional_information, :text
  end
end
