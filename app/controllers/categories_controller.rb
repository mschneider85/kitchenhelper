class CategoriesController < ApplicationController
  load_and_authorize_resource param_method: :category_attributes

  add_breadcrumb I18n.t('models.category', count: Category.count).titleize, :categories_path
  add_breadcrumb I18n.t('actions.create').titleize, :new_role_path, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_attributes)
    if @category.save
      redirect_to categories_path, notice: t('actions.created', model: @category.name)
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: t('actions.deleted', model: @category.name)
  end

private

  def category_attributes
    params.require(:category).permit(:name, :description)
  end
end
