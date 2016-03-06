class Admin::InventoryController < Admin::BaseController
  before_action :set_store, only: [:index]

  def index 
    @inventory = Item.where(store: @store).paginate(page: params[:page])
  end

  private
  def set_store
    @store = Store.find(params[:store_id])
  end
end
