class PagesController < ApplicationController
  def home
    @posts = Blogit::Post.for_feed.last(3)
  end

  def about
  end

  def contact
  end

  def become_partner
  end
end
