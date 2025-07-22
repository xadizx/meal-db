class ReviewsController < ApplicationController
  include AuthenticatedAccess

  def index
    # Current user's reviews
  end

  def create
    # Create review, nested under meal
  end

  def destroy
    # Delete review
  end

  private

  def meal
    @meal ||= Meal.find_by_external_id(params[:external_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment).merge(meal: meal)
  end
end
