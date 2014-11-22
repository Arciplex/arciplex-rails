class Contact < ActiveRecord::Base
    has_no_table

    column :name, :string
    column :email, :string
    column :phone_number, :string
    column :message, :string

    validates_presence_of :email, :name
end
