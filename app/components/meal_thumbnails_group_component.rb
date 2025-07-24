class MealThumbnailsGroupComponent < ViewComponent::Base
  def initialize(meal_cards:)
    @meal_cards = meal_cards
  end

  private

  attr_reader :meal_cards
end
