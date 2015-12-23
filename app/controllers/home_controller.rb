class HomeController < ApplicationController

    layout "home"

    def index
        @contact = Contact.new
    end

    def ssl
        render file: 'public/1327D73CAFF529BF483CCA3A87E33B1B.txt'
    end

end
