class RolesController < ApplicationController
  load_and_authorize_resource param_method: :role_attributes

  before_action :load_role, only: [:edit, :update, :destroy]

  add_breadcrumb 'Roles', :roles_path
  add_breadcrumb 'Create', :new_role_path, only: [:new, :create]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_attributes)
    if @role.save
      redirect_to roles_path, notice: t('messages.created', model: @role.name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_attributes)
      redirect_to roles_path, notice: t('messages.updated', model: @role.name)
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: t('messages.deleted', model: @role.name)
  end

private

  def role_attributes
    params.require(:role).permit(:name)
  end

  def load_role
    @role = Role.find(params[:id])
  end
end