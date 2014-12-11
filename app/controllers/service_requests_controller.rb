class ServiceRequestsController < ApplicationController
  before_filter :authenticate_user!, :get_company
  authorize_resource except: [:index, :update]
  load_resource except: [:create, :update, :index]

  respond_to :html, :js

  def index
    if params[:search]
      @service_requests = @company.service_requests.search(params[:search])
    else
      @service_requests = @company.service_requests
      @service_requests = @company.service_requests.send(params[:status]) if params[:status]
    end

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
    @service_request = @company.service_requests.new(service_request_params)
    @service_request.company_id = @company.id
    @service_request.set_creation_fields(current_user.id, source: "User")

    if @service_request.save
      @service_request.approved!
      redirect_to company_service_request_path(company_id: @company.id, id: @service_request), notice: "Serice Request successfully created!"
    else
      @service_request.line_items.build
      @service_request.build_customer
      render :new
    end
  end

  def update
    @service_request = ServiceRequest.find(params[:id])

    if @service_request.update_attributes(service_request_params)
      @service_request.approved! if params[:commit].eql? "Approve"
      respond_to do |format|
        format.html { redirect_to company_service_request_path(company_id: @company.id, id: @service_request), notice: "#{@service_request.id} updated successfully!" }
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
    @service_request = ServiceRequest.find(params[:id])

    authorize! :manage, @service_request

    @service_request.destroy
    redirect_to company_service_requests_path(company_id: @company.id), notice: "Service Request has been removed!"
  end

  def complete
    @service_request = ServiceRequest.find(params[:id])

    authorize! :manage, @service_request

    if @service_request.complete!
      redirect_to company_service_requests_path(company_id: @company.id), notice: "Service Request has been closed!"
    else
      redirect_to company_service_requests_path(company_id: @company.id), notice: "An error occurred. Please try again!"
    end
  end

  def received
    @service_request = ServiceRequest.find(params[:id])

    authorize! :manage, @service_request

    respond_to do |format|
      if @service_request.received!
        format.js {}
      else
        format.js { render json: { success: false, error: "An error has occurred!" }, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @service_request = ServiceRequest.find(params[:id])

    authorize! :approve, @service_request

    if @service_request.approved!
      redirect_to company_service_requests_path(company_id: @company.id), notice: "Service Request has been approved!"
    else
      redirect_to company_service_request_path(company_id: @company.id, id: params[:id]), notice: "Error has occurred. Please try again"
    end
  end

  def print
    @service_request = ServiceRequest.find_by email_hash_identifier: params[:email_hash_id]
    @company_name = @service_request.company.name
    @customer = @service_request.customer
    
    render layout: false
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
          :id,
          :prefix,
          :first_name,
          :last_name,
          :contact_email,
          :phone_number,
          shipping_information_attributes: [
            :id,
            :address,
            :address2,
            :company_name,
            :city,
            :state,
            :zip_code,
            :country,
            :address_type
          ]
        ],
        line_items_attributes: [
          :_destroy,
          :item_type,
          :id,
          :model_number,
          :serial_number,
          :additional_information,
          :activation_id,
          :warranty_void
        ]
      ]

      params.require(:service_request).permit(*service_request_attributes)
    end

    def get_company
      @company = Company.find(params[:company_id])
    end

    def not_found
      message = "Service Request not found"
      redirect_to company_service_requests_path(company_id: @company.id), notice: message
    end
end
