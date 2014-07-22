class ServiceRequestMailerWorker
  include Sidekiq::Worker

  def perform(service_request_id, company_id, send_to)
    @company = Company.find(company_id)
    @service_request = @company.service_requests.find(service_request_id)
    @customer = @service_request.customer
    WarrantyMailer.submitted(@service_request, @customer, send_to).deliver
  end
end
