class WarrantyMailer < ActionMailer::Base
  default from: "warranty@supportnotification.com"

  def submitted(service_request, customer, to)
    @customer = customer
    @service_request = service_request
    @company_name = service_request.company.name
    mail(to: to, subject: "[#{@company_name}] - Service Request")
  end
end
