class ReviewsController < ApplicationController
  include AuthenticatedAccess

  before_action :set_meal, only: [:create]
  before_action :set_review, only: [:destroy]

  def index
    @reviews = current_user.meal_reviews.includes(:meal).latest
  end

  def create
    @review = @meal.meal_reviews.build(review_params.merge(user: current_user))

    if @review.save
      render turbo_stream: [
        turbo_stream.prepend("reviews_list", ReviewComponent.new(review: @review, skip_review_id_tag: true)),
        *reviews_common_turbo_stream_response(@review)
      ]
    else
      render turbo_stream: [
        turbo_stream.replace("review_form", partial: "meals/review_form", locals: {meal: @meal, review: @review}),
        flash_turbo_stream(type: :alert, messages: @review.errors.full_messages)
      ]
    end
  end

  def destroy
    @meal = @review.meal

    if @review.destroy
      render turbo_stream: [
        turbo_stream.remove("review_#{@review.id}"),
        *reviews_common_turbo_stream_response(@review)
      ]
    else
      render turbo_stream: flash_turbo_stream(type: :alert, message: "Failed to delete review")
    end
  end

  private

  def set_review
    @review = current_user.meal_reviews.find(params[:id])
  end

  def set_meal
    @meal = Meal.find_by_external_id!(params[:external_id])
  end

  def review_params
    params.require(:meal_review).permit(:rating, :comment)
  end

  def reviews_common_turbo_stream_response(review)
    message = review.destroyed? ? "Review deleted successfully!" : "Review added successfully!"

    [
      turbo_stream.replace("meal_rating", partial: "meals/meal_rating", locals: {meal: @meal}),
      turbo_stream.replace("review_form", partial: "meals/review_form", locals: {meal: @meal, review: @meal.meal_reviews.build}),
      flash_turbo_stream(type: :success, message: message)
    ]
  end
end
