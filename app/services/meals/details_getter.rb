module Meals
  class DetailsGetter < ApplicationService
    PATH = "lookup.php"

    def initialize(external_id:)
      @client = TheMealDB::Client.new
      @external_id = external_id
    end

    def call
      return existing_meal if existing_meal.present?

      meal_details = fetch_meal_details
      save_meal(meal_details)
    end

    private

    attr_reader :client, :external_id

    def existing_meal
      @existing_meal ||= Meal.find_by_external_id(external_id)
    end

    def fetch_meal_details
      response = client.get(PATH, i: external_id)
      response["meals"].first
    end

    def save_meal(meal_details)
      Meals::Saver.call(meal_details: meal_details)
    end
  end
end
