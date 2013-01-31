class PostsController < ApplicationController
  before_filter :authenticate, :except => [:create]

  def index
    @posts = Post.list(params[:page])
  end

  def show
    @post = Post.show(params[:id])
  end

  def create
    post = Post.new_from_postmark(request.body.read)

    if post.save
      head :ok
    else
      head :forbidden
    end
  end

  def archive
    post = current_user.posts.where(:id => params[:id]).first

    if post.archive
      redirect_to root_path, :notice => 'Post has been successfully deleted.'
    else
      redirect_to post_path(post), :alert => 'Post could not be deleted.'
    end
  end
end
