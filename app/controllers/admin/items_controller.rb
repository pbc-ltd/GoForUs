class Admin::ItemsController < Admin::BaseController
  before_action :set_order, only: [:index]
  before_action :set_item, only: [
    :show, :edit, :update, :destroy
  ]
  
  def index 
    @items = @order.items
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_parmas)
  end

  def destroy
  end

  private
  def item_params
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
