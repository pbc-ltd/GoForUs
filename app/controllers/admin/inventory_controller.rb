class Admin::InventoryController < ApplicationController
  layout 'admin'
  before_action :set_store, only: [:index]

  def index 
    @inventory = Item.where(store: @store)
  end

  private
  def set_store
    @store = Store.find(params[:store_id])
  end
end
