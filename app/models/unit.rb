class Unit < ActiveRecord::Base
  has_many :ingredients
  has_many :ingredients_recipes
end
