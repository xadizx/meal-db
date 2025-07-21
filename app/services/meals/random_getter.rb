module Meals
  class RandomGetter < ApplicationService
    PATH = "random.php"

    def initialize
      @client = TheMealDB::Client.new
    end

    def call
      meal_details = random_meal
      existing_meal = Meal.find_by_external_id(meal_details["idMeal"])

      if existing_meal.present?
        existing_meal
      else
        Meals::Saver.call(meal_details: meal_details)
      end
    end

    private

    attr_reader :client

    def random_meal
      response = client.get(PATH)
      response["meals"].first
    end
  end
end
