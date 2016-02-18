class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_breadcrumb 'Home', :root_path

  before_action :authenticate_user!
  before_action :check_for_user_name, only: [:index, :show]

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

  def check_for_user_name
    if current_user && (current_user.first_name.blank? || current_user.last_name.blank?)
      redirect_to edit_user_registration_path
    end
  end

end
