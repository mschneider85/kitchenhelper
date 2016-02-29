class Category < ActiveRecord::Base
  has_many :categories_recipes
  has_many :recipes, through: :categories_recipes

  validates :name, uniqueness: true, presence: true
end
