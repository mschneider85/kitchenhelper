class UsersController < ApplicationController
  load_and_authorize_resource param_method: [:user_params, :user_password_params]

  before_action :load_user, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('models.user', count: User.count).titleize, :users_path
  add_breadcrumb I18n.t('actions.create').titleize, :new_user_path, only: [:new, :create]
  add_breadcrumb I18n.t('actions.edit').titleize, '', only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user == @current_user ? (add_breadcrumb I18n.t('paths.profile'), '') : (add_breadcrumb @user.name, '')
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
      redirect_to users_path, notice: t('actions.created', model: @user.name)
    else
      render :new
    end
  end

  def update
    @user.attributes = user_password_params unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    if @user.update(user_params)
      redirect_to users_path, notice: t('actions.updated', model: @user.name)
    else
      render :edit
    end
  end

  def destroy
    unless @user == current_user
      @user.destroy
      redirect_to users_path, notice: t('actions.deleted', model: @user.name)
    else
      redirect_to users_path, alert: t('actions.cant_delete_self')
    end
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
   params.require(:user).permit(:email, :first_name, :last_name, role_ids:[])
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
