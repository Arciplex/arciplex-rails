module Admin
  module DashboardHelper

    def display_logo(company, link = false)
      company = company.is_a?(Company) ? company : Company.find(company)

      if link
        link_to image_tag("logos/#{company.name.downcase}_logo.jpg", border: 0), company_service_requests_path(company.id)
      else
        image_tag("logos/#{company.name.downcase}_logo.jpg", border: 0)
      end
    end

  end
end