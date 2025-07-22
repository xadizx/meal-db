class MealThumbnailsGroupComponent < ViewComponent::Base
  def initialize(meal_thumbnails: [])
    @meal_thumbnails = meal_thumbnails
  end
end
