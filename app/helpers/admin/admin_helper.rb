module Admin
  module AdminHelper

    def display_company_name(id)
      Company.find(id).name
    end

  end
end