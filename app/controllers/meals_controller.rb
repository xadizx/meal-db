class MealsController < ApplicationController
  include AuthenticatedAccess

  before_action :set_meal, only: [:show, :toggle_favourite]

  def index
    @categories = Category.ordered.pluck(:name)
    @areas = Areas::Getter.call
  end

  def show
  end

  def favourite
    @meal_cards = current_user.favourited_meals.decorate.map(&:to_card)
  end

  def filter
    filter_type, filter_value = params[:filter_type], params[:filter_value]

    @meal_cards = Meals::Filter.call(filter_type: filter_type, filter_value: filter_value)

    render turbo_stream: turbo_stream.replace(
      "meals_results",
      partial: "meals/index/search_results",
      locals: {meal_cards: @meal_cards}
    )
  end

  def random
    @meal = Meals::RandomGetter.call
  end

  def toggle_favourite
    favourite_meal = FavouriteMeal.find_or_initialize_by(user: current_user, meal: @meal)
    initially_favourited = favourite_meal.persisted?

    if initially_favourited
      favourite_meal.destroy
    else
      favourite_meal.save
    end

    render turbo_stream: [
      turbo_stream.replace("favorite-button", partial: "meals/favorite_button", locals: {meal: @meal, favorited: !initially_favourited}),
      flash_turbo_stream(type: :success, message: toggle_favourite_message(initially_favourited))
    ]
  end

  private

  def set_meal
    @meal ||= Meal.includes(:meal_ingredients, :meal_reviews, meal_reviews: :user).find_by_external_id(params[:external_id]) || fetch_meal_from_api
  end

  def fetch_meal_from_api
    Meals::DetailsGetter.call(external_id: params[:external_id])
  end

  def toggle_favourite_message(initially_favourited)
    "Meal #{initially_favourited ? "removed from" : "added to"} favourites!"
  end
end
