require "dry-struct"

module Types
  include Dry.Types()
end

class MealCard < Dry::Struct
  attribute :external_id, Types::Integer
  attribute :name, Types::String
  attribute :thumbnail_image_url, Types::String
  attribute :category_name, Types::String
end
