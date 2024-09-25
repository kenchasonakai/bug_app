class PostsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    respond_to do |format|
      format.html do
        @post = current_user.posts.find(params[:id])
      end
      format.json do
        post = Post.find(params[:id])
        render json: { content: post.content }
      end
    end
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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました\n#{@post.errors.full_messages.join('\n')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: "削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :tag_list)
  end
end
