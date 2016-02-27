class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :categories_recipes
  has_many :categories, through: :categories_recipes
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
end
