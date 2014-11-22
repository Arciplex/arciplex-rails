class HomeController < ApplicationController

    layout "home"

    def index
        @contact = Contact.new
    end

end
