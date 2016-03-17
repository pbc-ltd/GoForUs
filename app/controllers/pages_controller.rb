class PagesController < ApplicationController
  def home
    @posts = Blogit::Post.active.last(3).reverse
  end

  def about
  end

  def contact
  end

  def become_partner
  end
end
