class Api::V1::PartnersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false, only: [:index]
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  # :lat(decimal)
  # :lng (decimal)
  # :radius(integer) (in meters)
  def index
    rad = index_params.fetch(:radius, 20_000)
    @partners = Partner.where(online: true).within_radius(rad, index_params.fetch(:lat), index_params.fetch(:lng))
  end

  def online
    user.available = online_params[:online]
    user.online = online_params[:online]
    if user.save
      if user.available && user.online
        OnlineTimerJob.set(wait: 15.minutes).perform_later(user, DateTime.now.to_i)
      end
      render json: { status: 'success', message: "You're now available and online" }
    else
      render json: { status: 'failed', message: "Something went wrong while turning you online!" } end
  end

  private
  def index_params
    params.require(:lat)
    params.require(:lng)
    params.permit(:radius)
    params
  end

  def online_params
    params.permit(:online)
  end
end
