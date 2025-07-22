module Meals
  class RandomGetter < ApplicationService
    def initialize
      @client = TheMealDB::Client.new
    end

    def call
      meal_details = fetch_random_meal
      existing_meal = Meal.find_by_external_id(meal_details["idMeal"])

      return existing_meal if existing_meal.present?

      Meals::Saver.call(meal_details: meal_details)
    end

    private

    attr_reader :client

    def fetch_random_meal
      response = client.get("random.php")
      response["meals"]&.first
    end
  end
end
