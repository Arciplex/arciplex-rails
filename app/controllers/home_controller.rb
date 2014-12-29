class HomeController < ApplicationController

    layout "home"

    def index
        @contact = Contact.new
    end

    def ssl
        render file: 'public/2A55AEA42BF229CF108577FED1861D32.txt'
    end

end
