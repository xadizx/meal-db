class FavouriteMeal < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validates :user_id, uniqueness: {scope: :meal_id, message: "has already favourited this meal"}
end
