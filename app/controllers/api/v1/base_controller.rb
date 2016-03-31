class Api::V1::BaseController < ActionController::Base
  respond_to :json
  protect_from_forgery with: :null_session

  def user
    @user ||= current_partner || current_customer
  end
end
