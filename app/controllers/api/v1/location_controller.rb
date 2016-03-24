class Api::V1::LocationController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  # /location/update
  def update
    if user.update(update_location_params)
      render json: { status: "ok" }
    else
      render json: { status: "invalid" }
    end
  end

  private
  def update_location_params
    params.require(:location).permit(:lat, :lng)
  end
end
