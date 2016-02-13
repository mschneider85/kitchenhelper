class UsersController < ApplicationController
  load_and_authorize_resource param_method: [:user_params, :user_password_params]
  before_action :load_user, only: [:edit, :update, :destroy]
  add_breadcrumb 'Users', :users_path
  add_breadcrumb 'Create', :new_user_path, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.attributes = user_password_params
    if @user.save
      redirect_to users_path, notice: t('messages.created', model: @user.name)
    else
      render :new
    end
  end

  def update
    @user.attributes = user_password_params unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    if @user.update(user_params)
      redirect_to users_path, notice: t('messages.updated', model: @user.name)
    else
      render :edit
    end
  end

  def destroy
    unless @user == current_user
      @user.destroy
      redirect_to users_path, notice: t('messages.deleted', model: @user.name)
    else
      redirect_to users_path, alert: t('messages.cant_delete_self')
    end
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
   params.require(:user).permit(:email, :first_name, :last_name, :role_id)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
