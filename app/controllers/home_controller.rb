class HomeController < ApplicationController

    layout "home"

    def index
        @contact = Contact.new
    end

    def ssl
        render file: 'public/2145904674DC90BBD8BEFFFDC0CC8861.txt'
    end

end
