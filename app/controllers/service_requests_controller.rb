class ServiceRequestsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource except: [:index, :update]
  load_resource except: [:create, :update]
  
  respond_to :html, :js
  
  def index
    @service_requests = @service_requests.send(params[:status]) if params[:status]
    @service_requests = @service_requests.paginate(page: params[:page])
  end
  
  def show
    customers
    respond_with @service_request
  end
  
  def new
    customers
    @service_request.line_items.build
  end
  
  def edit
    customers
    respond_with @service_request
  end
  
  def create
    @service_request = current_user.service_requests.new(service_request_params)
    
    if @service_request.save
      redirect_to service_request_path(@service_request), notice: "Serice Request successfully created!"
    else
      customers
      render :new
    end
  end
  
  def update
    @service_request = ServiceRequest.find(params[:id])
    
    if @service_request.update_attributes(service_request_params)
      respond_to do |format|
        format.html { redirect_to service_request_path(@service_request), notice: "#{@service_request.case_number} updated successfully!" }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
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
  
  def received
    @service_request = ServiceRequest.find(params[:id])
    
    authorize! :manage, @service_request
    
    respond_to do |format|
      if @service_request.received
        format.js {}
      else
        format.js { render json: { success: false, error: "An error has occurred!" }, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def service_request_params
      params.require(:service_request).permit(:id, :troubleshooting_reference, :rma, :customer_id, :additional_information).tap do |whitelisted|
        whitelisted[:line_items_attributes] = params[:service_request][:line_items_attributes] if params[:service_request].has_key?(:line_items_attributes)
      end
    end
    
    def customers
      @customers = Customer.in_company(current_user.company_id)
    end
end