class RecipesController < ApplicationController
  add_breadcrumb I18n.t('models.recipe', count: 2).titleize, :recipes_path
  add_breadcrumb I18n.t('actions.create').titleize, :new_recipe_path, only: [:new, :create]

  before_action :load_recipe, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def update
    if @recipe.update(recipe_attributes)
      redirect_to recipes_path, notice: t('actions.updated', model: @recipe.name)
    else
      render :edit
    end
  end

  def create
    @recipe = Recipe.new(recipe_attributes)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path, notice: t('actions.created', model: @recipe.name)
    else
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: t('actions.deleted', model: @recipe.name)
  end

private

  def load_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_attributes
    params.require(:recipe).permit(:name, :portions, :cooking, :duration, :user_id, ingredients_recipes_attributes: [:id, :amount, :note, :ingredient_name, :unit_id, :_destroy])
  end
end
