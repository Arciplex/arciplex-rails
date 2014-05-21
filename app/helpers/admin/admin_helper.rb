module Admin
  module AdminHelper

    def display_company_name(id)
      Company.find(id).name
    end

    def convert_opened_to_open(status)
      status.eql?("opened") ? "open" : status
    end

  end
end
