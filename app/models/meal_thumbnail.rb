require "dry-struct"

module Types
  include Dry.Types()
end

class MealThumbnail < Dry::Struct
  attribute :external_id, Types::Integer
  attribute :name, Types::String
  attribute :thumbnail_url, Types::String
end
