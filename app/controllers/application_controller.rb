class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) << :name
  end


  private
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_invite_path_for(resource)
    users_path
  end

end
