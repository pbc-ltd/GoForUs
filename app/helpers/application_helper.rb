module ApplicationHelper
  def base_application
    Rails.application.routes.url_helpers
  end

  def blog_application
    Blogit::Engine.routes.url_helpers
  end
end
