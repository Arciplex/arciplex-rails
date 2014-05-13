class OrdersController < ApplicationController
  before_filter :authenticate_user!, :get_company
  authorize_resource except: [:index, :update]
  load_resource except: [:create, :update]

  respond_to :html, :js

  def index
    @orders = @company.orders.where('status != ?', 'closed') unless params[:status]
    @orders = @orders.send(params[:status]) if params[:status]
    @orders = @orders.paginate(page: params[:page])
  end

  def show
    respond_with @order
  end

  def new
    @order.order_line_items.build
    @order.build_customer
  end

  def edit
    respond_with @order
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.company_id = current_user.admin? ? params[:company_id] : current_user.company_id

    if @order.save
      @order.notify
      redirect_to company_order_path(company_id: params[:company_id], id: @order), notice: "Order successfully created!"
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      @order.notify
      respond_to do |format|
        format.html { redirect_to company_order_path(company_id: params[:company_id], id: @order), notice: "Order updated successfully!" }
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
    @order = Order.find(params[:id])
    if @order.complete!
      redirect_to company_orders_path(company_id: params[:company_id]), notice: "Order has been closed!"
    else
      redirect_to company_orders_path(company_id: params[:company_id]), notice: "An error occurred. Please try again!"
    end
  end

  def received
    @order = Order.find(params[:id])

    authorize! :manage, @order

    respond_to do |format|
      if @order.received!
        @order.notify
        format.js {}
      else
        format.js { render json: { success: false, error: "An error has occurred!" }, status: :unprocessable_entity }
      end
    end
  end

  private

    def order_params
      order_attributes = [
        :id,
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

      params.require(:order).permit(*order_attributes).tap do |whitelisted|
        if params[:order].has_key?(:order_line_items_attributes)
          whitelisted[:order_line_items_attributes] = params[:oredr][:order_line_items_attributes]
        end
      end
    end

    def get_company
      @company = Company.find(params[:company_id])
    end
end
