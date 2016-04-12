class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :categories_recipes, dependent: :destroy
  has_many :categories, through: :categories_recipes
  has_many :ingredients_recipes, dependent: :destroy, validate: true
  has_many :ingredients, through: :ingredients_recipes

  accepts_nested_attributes_for :ingredients_recipes, allow_destroy: true

  validates :name, presence: true
  validates :ingredients_recipes, presence: true
end
