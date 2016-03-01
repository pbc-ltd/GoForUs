class Admin::StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  
  layout 'admin'

  def index 
    @stores = Store.where(nil)
  end

  def show
  end

  def edit
  end

  def update
    @store.update(store_params)
  end

  def destroy
  end

  private
  def store_params
    #TODO
  end

  def set_store
    @store = store.find(params[:id])
  end
end
