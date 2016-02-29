class UnitsController < ApplicationController
  load_and_authorize_resource param_method: :unit_attributes

  add_breadcrumb I18n.t('models.unit', count: Unit.count).titleize, :units_path
  add_breadcrumb I18n.t('actions.create').titleize, :new_role_path, only: [:new, :create]

  def index
    @units = Unit.all
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_attributes)
    if @unit.save
      redirect_to units_path, notice: t('actions.created', model: t('models.unit', count: 1))
    else
      render :new
    end
  end

  def destroy
    @unit.destroy
    redirect_to units_path, notice: t('actions.deleted', model: t('models.unit', count: 1))
  end

private

  def unit_attributes
    params.require(:unit).permit(:short_name, :full_name)
  end
end
