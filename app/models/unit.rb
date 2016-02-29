class Unit < ActiveRecord::Base
  has_many :ingredients
  has_many :ingredients_recipes

  validates :short_name, presence: true, uniqueness: true
end
