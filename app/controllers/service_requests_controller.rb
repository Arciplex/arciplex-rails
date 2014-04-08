class ServiceRequestsController < ApplicationController
  before_filter :authenticate_user!, :get_company
  authorize_resource except: [:index, :update]
  load_resource except: [:create, :update]
  
  respond_to :html, :js
  
  def index
    @service_requests = @service_requests.send(params[:status]) if params[:status]
    @service_requests = @service_requests.paginate(page: params[:page])
  end
  
  def show
    respond_with @service_request
  end
  
  def new
    @service_request.line_items.build
    @service_request.build_customer
  end
  
  def edit
    respond_with @service_request
  end
  
  def create
    @service_request = current_user.service_requests.new(service_request_params)
    @service_request.company_id = current_user.admin? ? params[:company_id] : current_user.company_id
    
    if @service_request.save
      redirect_to company_service_request_path(company_id: params[:company_id], id: @service_request), notice: "Serice Request successfully created!"
    else
      render :new
    end
  end
  
  def update
    @service_request = ServiceRequest.find(params[:id])
    
    if @service_request.update_attributes(service_request_params)
      respond_to do |format|
        format.html { redirect_to company_service_request_path(company_id: params[:company_id], id: @service_request), notice: "#{@service_request.case_number} updated successfully!" }
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
      redirect_to company_service_requests_path(company_id: params[:company_id]), notice: "Service Request has been removed!"
    else
      redirect_to company_service_requests_path(company_id: params[:company_id]), notice: "An error occurred. Please try again!"
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
      service_request_attributes = [
        :id,
        :troubleshooting_reference,
        :rma,
        :additional_information,
        :ship_date,
        :carrier,
        :tracking_number,
        customer_attributes: [
          :prefix,
          :first_name,
          :last_name,
          :contact_email,
          :phone_number,
          shipping_information_attributes: [
            :address,
            :address2,
            :city,
            :state,
            :zip_code,
            :country,
            :address_type
          ]
        ]
      ]

      params.require(:service_request).permit(*service_request_attributes).tap do |whitelisted|
        if params[:service_request].has_key?(:line_items_attributes)
          whitelisted[:line_items_attributes] = params[:service_request][:line_items_attributes]
        end
      end
    end

    def get_company
      @company = Company.find(params[:company_id])
    end
end