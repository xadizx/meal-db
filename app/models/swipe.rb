class Swipe < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  enum :preference, {disliked: 0, liked: 1}

  validates :user_id, uniqueness: {scope: :meal_id}
  validates :preference, presence: true
end
