class AddReceivesCommunicationsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :receives_communication, :boolean, default: true
  end
end
