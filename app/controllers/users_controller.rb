class UsersController < ApplicationController
  before_filter :authenticate_owner!, only: [:edit, :update]
  before_filter :set_user, only: [:show, :edit, :update, :follow, :unfollow]

  def index
    authorize! :index, @users
    @users = User.all
  end

  def show
    @posts = @user.find_up_voted_items
  end

  def edit
    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  def follow
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def unfollow
    current_user.stop_following(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:avatar, :avatar_cache, :remove_avatar, profile_attributes: [:id, :name, :birthday, :tel, :location, :bio])
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end

end
