class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      flash.now[:alert] = "投稿に失敗しました\n#{@post.errors.full_messages.join('\n')}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
