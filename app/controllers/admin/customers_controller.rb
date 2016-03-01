class Admin::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  
  layout 'admin'

  def index 
    @customers = Customer.where(nil)
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(customer_params)
  end

  def destroy
  end

  private
  def customer_params
    #TODO
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
