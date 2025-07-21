class Category < ApplicationRecord
  has_many :meals, inverse_of: :category, dependent: :nullify

  validates :external_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :thumbnail_url, :description, presence: true
end
