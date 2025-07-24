class MealThumbnailComponent < ViewComponent::Base
  def initialize(meal_card:)
    @meal_card = meal_card
  end

  private

  attr_reader :meal_card
end
