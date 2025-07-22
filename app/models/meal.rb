class Meal < ApplicationRecord
  include ExternalIdentifiable

  belongs_to :category, inverse_of: :meals
  has_many :meal_ingredients, inverse_of: :meal, dependent: :destroy
  has_many :meal_reviews, dependent: :destroy
  has_many :favourite_meals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :thumbnail_url, :instructions, :area, presence: true
end
