class Meal < ApplicationRecord
  belongs_to :category, inverse_of: :meals
  has_many :meal_ingredients, inverse_of: :meal, dependent: :destroy

  validates :external_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :thumbnail_url, :tags, :instructions, :area, presence: true
end
