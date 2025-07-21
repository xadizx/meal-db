class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_many :meal_reviews, dependent: :destroy
  has_many :rated_meals, through: :meal_reviews, source: :meal
  has_many :favourite_meals, dependent: :destroy
  has_many :favourited_meals, through: :favourite_meals, source: :meal
end
