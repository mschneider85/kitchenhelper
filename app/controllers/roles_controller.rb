class RolesController < ApplicationController
  load_and_authorize_resource param_method: :role_attributes

  add_breadcrumb I18n.t('models.role', count: Role.count).titleize, :roles_path
  add_breadcrumb I18n.t('actions.create').titleize, :new_role_path, only: [:new, :create]

  def index
    @roles = Role.includes(:users)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_attributes)
    if @role.save
      redirect_to roles_path, notice: t('actions.created', model: @role.name)
    else
      render :new
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: t('actions.deleted', model: @role.name)
  end

private

  def role_attributes
    params.require(:role).permit(:name)
  end
end
