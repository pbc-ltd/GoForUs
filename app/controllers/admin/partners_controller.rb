class Admin::PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]
  
  layout 'admin'

  def index 
    @partners = Partner.where(nil)
  end

  def show
  end

  def edit
  end

  def update
    @partner.update(partner_params)
  end

  def destroy
  end

  private
  def partner_params
    #TODO
  end

  def set_partner
    @partner = Partner.find(params[:id])
  end
end
