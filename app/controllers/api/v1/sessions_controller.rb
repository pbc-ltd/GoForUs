class Api::V1::SessionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false, only: [:update, :destroy]
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false, only: [:update, :destroy]

  # PUT /api/v1/login
  def create
    @user = User.find_for_authentication(email: login_params.fetch(:email))

    unless @user
      render json: {
        error: { email: "unable to find account with email(#{login_params.fetch(:email)})" }
      }
      return
    end

    unless @user.valid_password?(login_params.fetch(:password))
      render json: {
        error: { password: 'incorrect password' }
      }
    end

    @user.online = true
    @user.save
  end

  def update
    user.update(:gcm_device_token)
  end

  def destroy
    user.authentication_token = nil
    user.online = false
    user.available = false
    user.save
    render json: { status: 'ok' }
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end

  def update_params
    parmas.require(:user).permit(:gcm_token)
  end
end
