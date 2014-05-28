module Admin
  module AdminHelper

    def display_company_name(id)
      Company.find(id).name
    end

    def convert_opened_to_open(status, upcase: false)
      val = status.casecmp("opened") == 0 ? "open" : status
      return val.capitalize if upcase
      return val
    end

  end
end
