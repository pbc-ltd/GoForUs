module Admin::NavigationHelper
  def navigation_list_item_link_to(name, path)
    raw("<li #{current_page?(path) ? 'class="active"' : '' }>" + (link_to name, path) + "</li>")
  end
end
