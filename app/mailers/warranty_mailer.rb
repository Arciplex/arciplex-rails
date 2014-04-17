class WarrantyMailer < ActionMailer::Base
  default from: "warranty@supportnotifications.com"

  def submitted(service_request, customer, to)
    @customer = customer
    @service_request = service_request
    @company_name = service_request.company.name
    mail(to: to, subject: "Service Request Submitted")
  end
end
