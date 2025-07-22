class Meal < ApplicationRecord
  include ExternalIdentifiable

  belongs_to :category, inverse_of: :meals
  has_many :meal_ingredients, inverse_of: :meal, dependent: :destroy
  has_many :meal_reviews, dependent: :destroy
  has_many :favourite_meals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :thumbnail_image_url, :instructions, :area, presence: true

  def average_rating
    return 0.0 if meal_reviews.empty?

    meal_reviews.average(:rating).to_f.round(1)
  end

  def review_count
    meal_reviews.count
  end

  def main_ingredient
    meal_ingredients.first&.name || "Not specified"
  end
end
