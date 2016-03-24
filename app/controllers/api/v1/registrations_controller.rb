class Api::V1::RegistrationsController < Api::V1::BaseController

  # POST /api/v1/register
  def create
    @customer = Customer.new(sign_up_params)
  end

  private
  def sign_up_params
    params.require(:customer).permit(:email, :phone_number, :name, :password)
  end
end
