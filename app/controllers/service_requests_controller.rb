class ServiceRequestsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :js
  
  def index
    @service_requests = current_user.service_requests
  end
  
  def show
    @service_request = current_user.service_requests.find(params[:id])
    respond_with @service_request
  end
  
  def new
    customers
    @service_request = ServiceRequest.new
    @service_request.line_items.build
  end
  
  def edit
    customers
    @service_request = current_user.service_requests.find(params[:id])
    respond_with @service_request
  end
  
  def create
    @service_request = current_user.service_requests.new(service_request_params)
    
    if @service_request.save
      redirect_to new_service_request_path, notice: "Serice Request successfully created!"
    else
      customers
      render :new
    end
  end
  
  def update
    @service_request = current_user.service_requests.find params[:id]
    
    if @service_request.update_attributes service_request_params
      redirect_to service_request_path(@service_request), notice: "#{@service_request.case_number} updated successfully!"
    else
      render :edit
    end
  end
  
  def destroy
    @service_request = current_user.service_requests.find(params[:id])
    if @service_request.destroy
      redirect_to service_requests_path, notice: "Service Request has been removed!"
    else
      redirect_to service_requests_path, notice: "An error occurred. Please try again!"
    end
  end
  
  private
    def service_request_params
      params.require(:service_request).permit(:troubleshooting_reference, :rma, :customer_id).tap do |whitelisted|
        whitelisted[:line_items_attributes] = params[:service_request][:line_items_attributes]
      end
    end
    
    def customers
      @customers = Customer.in_company(current_user.company_id)
    end
end