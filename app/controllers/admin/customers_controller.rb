class Admin::CustomersController < Admin::BaseController
  include ::Deactivateable::Controller

  before_action :set_customer, only: [
    :show, :edit, :update, :destroy
  ]
  
  def index 
    @customers = Customer.where(nil)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :show
    end
  end

  def destroy
    if @customer.destroy!
      redirect_to admin_customer_path(@customer.id)
    else
      render :show
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:mobile_number, :name)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
