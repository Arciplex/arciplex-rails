class ContactsController < ApplicationController

    respond_to :js

    def create
        @contact = Contact.new(contacts_params)
        ContactMailer.submission(@contact).deliver if @contact.valid?

        respond_with @contact
    end

    private
        def contacts_params
            params.require(:contact).permit(:name, :email, :message, :phone_number)
        end
end
