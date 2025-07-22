class MealsController < ApplicationController
  include AuthenticatedAccess

  def index
    @thumbnails = current_user.favourited_meals.decorate.map(&:to_thumbnail)
  end

  def show
    # Display meal by external_id
  end

  def browse
    # Search by category/name/country + maybe ingredients
  end

  def random
    # Random meal
  end

  def toggle_favourite
    # Toggle favourite status
  end

  private

  def meal
    @meal ||= Meal.find_by_external_id(params[:external_id])
  end
end
