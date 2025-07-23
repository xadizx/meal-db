class MealsController < ApplicationController
  include AuthenticatedAccess

  before_action :set_meal, only: [:show, :toggle_favourite]

  def index
    @thumbnails = current_user.favourited_meals.decorate.map(&:to_thumbnail)
  end

  def show
  end

  def browse
    # Search by category/name/country + maybe ingredients
  end

  def random
    @meal = Meals::RandomGetter.call
  end

  def toggle_favourite
    if @meal.favorited_by?(current_user)
      favourite = current_user.favourite_meals.find_by(meal: @meal)
      favourite&.destroy
      favorited = false
    else
      current_user.favourite_meals.create(meal: @meal)
      favorited = true
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "favorite-button",
          partial: "meals/favorite_button",
          locals: {meal: @meal, favorited: favorited}
        )
      end
      format.html { redirect_to meal_path(@meal.external_id) }
    end
  end

  private

  def set_meal
    @meal ||= Meal.includes(:meal_ingredients, :meal_reviews).find_by_external_id!(params[:external_id])
  end
end
