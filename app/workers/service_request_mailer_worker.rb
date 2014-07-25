class ServiceRequestMailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(service_request_id, send_to)
    @service_request = ServiceRequest.find(service_request_id)
    @customer = @service_request.customer
    WarrantyMailer.submitted(@service_request, @customer, send_to).deliver
  end
end
