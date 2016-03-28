class KeepPostsController < ApplicationController
  before_action :set_post

  def create
    if Keep.create(kept: @post, user: current_user)
      redirect_to :back, notice: 'Kept in Mind'
    else
      redirect_to :back, alert: 'Something went wrong...*sad panda*'
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
