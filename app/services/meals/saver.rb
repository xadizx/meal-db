module Meals
  class Saver < ApplicationService
    def initialize(meal_details:)
      @meal_details = meal_details
    end

    def call
      meal = nil

      ActiveRecord::Base.transaction do
        meal = create_meal
        import_ingredients_for(meal)
      end

      meal
    end

    private

    attr_reader :meal_details

    def create_meal
      Meal.create!(
        external_id: meal_details["idMeal"],
        name: meal_details["strMeal"],
        thumbnail_image_url: meal_details["strMealThumb"],
        tags: meal_details["strTags"],
        instructions: meal_details["strInstructions"],
        area: meal_details["strArea"],
        category: category
      )
    end

    def category
      Category.find_by!(name: meal_details["strCategory"])
    end

    def import_ingredients_for(meal)
      MealIngredient.import!(parsed_meal_ingredient_attributes(meal.id))
    end

    def parsed_meal_ingredient_attributes(meal_id)
      (1..20).map do |index|
        ingredient_name = meal_details["strIngredient#{index}"]

        next if ingredient_name.blank?

        {
          meal_id: meal_id,
          name: ingredient_name,
          measurement: meal_details["strMeasure#{index}"]
        }
      end.compact
    end
  end
end
