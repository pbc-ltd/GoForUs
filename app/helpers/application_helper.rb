module ApplicationHelper
  def base_application
    Rails.application.routes.url_helpers
  end

  def blog_application
    Blogit::Engine.routes.url_helpers
  end

  def current_url
    request.base_url + request.original_fullpath
  end

  # Displays object errors
  def form_errors_for(object=nil)
    render(partial: 'shared/form_errors', locals: {  object: object }) unless object.blank?
  end
end
