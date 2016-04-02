class UsersController < ApplicationController
before_filter :authenticate_user!

  def index
    authorize! :index, @users
    @users = User.all

  end

end
