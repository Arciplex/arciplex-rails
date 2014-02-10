class CustomersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_customer
  skip_before_filter :load_customer, only: [:create, :update]
  
  respond_to :html, :js
  
  def index
    @customers = Customer.in_company(current_user.company_id)
  end
  
  def create
    @customer = Customer.new(customer_params)
    @customer.user_id = current_user.id
    @customer.company_id = current_user.company.id
    
    if @customer.save
      flash[:notice] = "Customer created successfully!"
      redirect_to customers_path
    else
      render :new
    end
  end
  
  def update
    @customer = current_user.customers.find params[:id]
    
    if @customer.update_attributes customer_params
      flash[:notice] = "#{@customer.full_name} updated successfully!"
      redirect_to customer_path @customer
    else
      render :edit
    end
  end
  
  def destroy
    @customer.destroy
    flash[:notice] = "Customer destroyed!"
    redirect_to customers_path
  end
  
  private
    def load_customer
      if params[:id]
        @customer = Customer.in_company(current_user.company_id).find(params[:id])
      else
        @customer = Customer.new
        @customer.build_shipping_information
      end
    end
  
    def customer_params
      params.require(:customer).permit(:prefix, :first_name, :last_name, :contact_email, :phone_number, 
                                      shipping_information_attributes: [:address, :address2, :city, :state, :zip_code, :country, :address_type])
    end
end