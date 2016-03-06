class Admin::PartnersController < Admin::BaseController
  include ::Deactivateable::Controller

  before_action :set_partner, only: [
    :show, :edit, :update, :destroy
  ]

  def index 
    @partners = Partner.where(nil).paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partner_path(@partner.id)
    else
      render :show
    end
  end

  def destroy
    if @partner.destroy!
      redirect_to admin_partner_path(@partner.id)
    else
      render :show
    end
  end

  private
  def partner_params
    params.require(:partner).permit(:mobile_number, :name)
  end

  def set_partner
    @partner = Partner.find(params[:id])
  end
end
