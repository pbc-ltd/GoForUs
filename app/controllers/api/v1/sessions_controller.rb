class Api::V1::SessionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false, only: [:destroy]
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false, only: [:destroy]

  # PUT /api/v1/login
  def create
    @customer = Customer.find_for_authentication(email: login_params.fetch(:email))

    unless @customer
      render json: {
        error: { email: "unable to find account with email(#{login_params.fetch(:email)})" }
      }
      return
    end

    unless @customer.valid_password?(login_params.fetch(:password))
      render json: {
        error: { password: 'incorrect password' }
      }
    end
  end

  def destroy
    user.authentication_token = nil
    user.save
    render json: { status: "ok" }
  end

  private
  def login_params
    params.require(:customer).permit(:email, :password)
  end
end
