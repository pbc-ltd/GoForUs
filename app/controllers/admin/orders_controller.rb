class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index 
    @orders = Order.where(nil)
  end

  def show
  end

  def edit
  end

  def update
    @order.update(order_params)
  end

  def destroy
  end

  private
  def order_params
    #TODO
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
