class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:edit, :update, :destroy]

  def new
    @post = Blogit::Post.new(state: Blogit.configuration.active_states.first)
  end

  def edit
  end

  def create
    @post = current_admin.blog_posts.new(post_params)
    if @post.save
      redirect_to blog.post_path(@post)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to blog.post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy!
      redirect_to blog.posts_path
    else
      redirect_to :back
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :description, :state, :tag_list)
  end

  def set_post
    @post = Blogit::Post.active_with_id(params[:id])
  end

  def blog
    Blogit::Engine.routes.url_helpers
  end
end
