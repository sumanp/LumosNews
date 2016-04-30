class KeepPostsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_filter :authenticate_user!

  def index

    @posts = current_user.keep_posts.paginate(:page => params[:page], per_page: 30).order('created_at DESC')
  end

  def create
    if Keep.create(kept: @post, user: current_user)
      redirect_to :back, notice: 'Kept in Mind'
    else
      redirect_to :back, alert: 'Something went wrong...*sad pingu*'
    end
  end

  def destroy
    Keep.where(kept_id: @post.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Forgot'
  end

  private

  def set_post
    @post = Post.find(params[:post_id] || params[:id])
  end
end
