class MealIngredient < ApplicationRecord
  belongs_to :meal, inverse_of: :meal_ingredients

  validates :name, :measurement, presence: true
end
