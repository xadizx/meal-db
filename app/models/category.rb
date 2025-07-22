class Category < ApplicationRecord
  include ExternalIdentifiable

  has_many :meals, inverse_of: :category, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :thumbnail_url, :description, presence: true

  scope :ordered, -> { order(name: :asc) }
end
