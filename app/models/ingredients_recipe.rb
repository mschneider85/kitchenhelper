class IngredientsRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit

  validates :amount, numericality: {greater_than: 0, allow_blank: true}
  validates :ingredient_name, presence: true

  def ingredient_name
    ingredient && ingredient.name
  end

  def ingredient_name=(name)
    self.ingredient = Ingredient.find_or_create_by(name: name) unless name.blank?
  end
end
