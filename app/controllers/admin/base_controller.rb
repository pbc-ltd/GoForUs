class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout 'admin'

  def after_sign_in_path_for(resource)
    admin_dashboard_index_path
  end

  def after_sign_out_path_for(resource)
    admin_dashboard_index_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.params.permit(:sign_in) do |admin_params|
      admin_params.permit({ roles: [] }, :email, :password, :password_confirmation)
    end
  end
end
