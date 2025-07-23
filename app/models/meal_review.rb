class MealReview < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validates :rating, allow_nil: false, numericality: {only_integer: true, greater_than: 0, less_than: 6}
  validates :user_id, uniqueness: {scope: :meal_id, message: "has already reviewed this meal"}
  validates :comment, presence: true, length: {minimum: 3, maximum: 1000}
end
