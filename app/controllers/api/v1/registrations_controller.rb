class Api::V1::RegistrationsController < Api::V1::BaseController

  # POST /api/v1/register
  def create
    @customer = Customer.new(register_params)
  end

  private
  def register_params
    params.require(:customer).permit(:email, :phone_number, :name, :password)
  end
end
