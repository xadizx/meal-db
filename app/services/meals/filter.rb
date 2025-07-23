module Meals
  class Filter < ApplicationService
    FILTER_TYPES = {
      category: "c",
      area: "a",
      ingredient: "i"
    }.freeze

    def initialize(filter_type:, filter_value:)
      @client = TheMealDB::Client.new
      @filter_type = filter_type.to_sym
      @filter_value = filter_value
    end

    def call
      ensure_valid_filter_type!

      meals.map do |meal|
        MealThumbnail.new(
          external_id: meal["idMeal"].to_i,
          name: meal["strMeal"],
          thumbnail_image_url: meal["strMealThumb"],
          category_name: filter_value.titleize
        )
      end
    end

    private

    attr_reader :client, :filter_type, :filter_value

    def ensure_valid_filter_type!
      raise ArgumentError, "Invalid filter type" unless FILTER_TYPES.key?(filter_type)
    end

    def meals
      response = client.get("filter.php", {param_key => filter_value}, cache_key: cache_key)
      response["meals"] || []
    end

    def param_key
      FILTER_TYPES[filter_type]
    end

    def cache_key
      "meals_#{filter_type}_#{filter_value}"
    end
  end
end
