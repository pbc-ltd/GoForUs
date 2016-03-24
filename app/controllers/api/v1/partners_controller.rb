class Api::V1::PartnersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  # :lat(decimal)
  # :lng (decimal)
  # :radius(integer) (in meters)
  def index
    rad = index_params.fetch(:radius, 20_000)
    @partners = Partner.within_radius(rad, index_params.fetch(:lat), index_params.fetch(:lng))
  end

  private
  def index_params
    params.require(:lat)
    params.require(:lng)
    params.permit(:radius)
    params
  end
end
