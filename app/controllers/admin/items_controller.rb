class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [
    :show, :edit, :update, :destroy
  ]
  
  layout 'admin'

  def index 
    @item = Item.where(nil)
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
    #TODO
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
