class ServiceRequestsController < ApplicationController
  def index
    
  end
  
  def show
  end
  
  def new
    @customers = Customer.in_company(current_user.company_id)
    @service_request = ServiceRequest.new
    @service_request.line_items.build
  end
  
  def create
    @service_request = current_user.service_requests.new(service_request_params)
    
    if @service_request.save
      redirect_to new_service_request_path, notice: "Serice Request successfully created!"
    else
      render :new
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def service_request_params
      params.require(:service_request).permit(:troubleshooting_reference, :rma, :customer_id).tap do |whitelisted|
        whitelisted[:line_items_attributes] = params[:service_request][:line_items_attributes]
      end
    end
end