class SwipesController < ApplicationController
  include AuthenticatedAccess

  def show
    @meal = next_meal_for(current_user)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @meal = Meal.find(params[:meal_id])
    Swipe.create!(user: current_user, meal: @meal, preference: params[:preference])
    @next_meal = next_meal_for(current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to swipe_path }
    end
  end

  private

  def next_meal_for(user)
    Meal
      .where.not(id: user.swipes.select(:meal_id))
      .order("RANDOM()")
      .first
  end
end
