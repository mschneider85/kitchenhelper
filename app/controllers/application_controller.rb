class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  add_breadcrumb 'Home', :root_path
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private

  def after_sign_in_path_for(resource)
    users_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def layout_by_resource
    if devise_controller?
      "application"
    else
      "application"
    end
  end

end
