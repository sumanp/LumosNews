class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
    @followers = Follow.for_followable(@tag)
  end

  def follow
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    current_user.follow(@tag)
    redirect_to :back
  end

  def unfollow
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    current_user.stop_following(@tag)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
