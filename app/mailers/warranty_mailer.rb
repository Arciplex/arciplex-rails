class WarrantyMailer < ActionMailer::Base
  default from: "warranty@supportnotification.com"

  def submitted(service_request, customer, to)
    @customer = customer
    @service_request = service_request
    @company_name = service_request.company.name
    mail(to: to, subject: "[#{@company_name}] - Service Request")
  end

  def due_notice(email, first_name, case_number)
    @first_name = first_name
    @case_number = case_number
    mail(to: email, subject: "Service Request due in two days!", from: "mrfixit@arciplex.com")
  end
end
