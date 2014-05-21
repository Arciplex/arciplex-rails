module Admin
  module DashboardHelper

    def display_logo(company, target: "", link: false, data: {})
      company = company.is_a?(Company) ? company : Company.find(company)

      if link
        link_to image_tag("logos/#{company.name.downcase}_logo.jpg", border: 0), target, data: data
      else
        image_tag("logos/#{company.name.downcase}_logo.jpg", border: 0)
      end
    end

  end
end
