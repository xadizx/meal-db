class Meal < ApplicationRecord
  belongs_to :category, inverse_of: :meals
  has_many :meal_ingredients, inverse_of: :meal, dependent: :destroy
  has_many :meal_reviews, dependent: :destroy
  has_many :favourite_meals, dependent: :destroy

  validates :external_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :thumbnail_url, :instructions, :area, presence: true

  def self.find_by_external_id(external_id)
    find_by(external_id: external_id)
  end
end
