class ReviewsController < ApplicationController
  include AuthenticatedAccess

  before_action :set_meal, only: [:create]
  before_action :set_review, only: [:destroy]

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

  def set_review
    @review = Review.find!(params[:id])
  end

  def set_meal
    @meal = Meal.find_by_external_id!(params[:external_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment).merge(meal: meal)
  end
end
