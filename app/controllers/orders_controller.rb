class OrdersController < ApplicationController
  # before_filter :authenticate_user!, :get_company
  before_filter :disable
  # authorize_resource except: [:index, :update]
  # load_resource except: [:create, :update]

  respond_to :html, :js

  def index
    if params[:search]
        @orders = @company.orders.search(params[:search])
    else
      @orders = @company.orders
      @orders = @company.orders.send(params[:status]) if params[:status]
    end

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
    @order.company_id = @company.id

    if @order.save
      # @order.notify
      redirect_to company_order_path(company_id: @company.id, id: @order), notice: "Order successfully created!"
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      # @order.notify
      respond_to do |format|
        format.html { redirect_to company_order_path(company_id: @company.id, id: @order), notice: "Order updated successfully!" }
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

    authorize! :manage, @order

    @order.destroy
    redirect_to company_orders_path(company_id: @company.id), notice: "Order has been removed!"
  end

  def complete
    @order = Order.find(params[:id])
    if @order.complete!
      redirect_to company_orders_path(company_id: @company.id), notice: "Order has been closed!"
    else
      redirect_to company_orders_path(company_id: @company.id), notice: "An error occurred. Please try again!"
    end
  end

  def received
    @order = Order.find(params[:id])

    authorize! :manage, @order

    respond_to do |format|
      if @order.received!
        # @order.notify
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
            :city,
            :state,
            :zip_code,
            :country,
            :address_type
          ]
        ],
        order_line_items_attributes: [
          :_destroy,
          :id,
          :item,
          :quantity,
          :additional_information,
          :serial_number
        ]
      ]

      params.require(:order).permit(*order_attributes)
    end

    def get_company
      @company = Company.find(params[:company_id])
    end

    def disable
        redirect_to after_sign_in_path_for(current_user), notice: "Orders has been disabled"
    end
end
