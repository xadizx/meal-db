class ReviewsController < ApplicationController
  include AuthenticatedAccess
  include FlashMessages

  before_action :set_meal, only: [:create]
  before_action :set_review, only: [:destroy]

  def index
    @reviews = current_user.meal_reviews.includes(:meal).latest
  end

  def create
    @review = @meal.meal_reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("reviews_list", partial: "meals/reviews_list", locals: {meal: @meal}),
            turbo_stream.replace("meal_rating", partial: "meals/meal_rating", locals: {meal: @meal}),
            turbo_stream.replace("review_form", partial: "meals/review_form", locals: {meal: @meal, review: @meal.meal_reviews.build}),
            flash_turbo_stream(type: :success, message: "Review added successfully!")
          ]
        end
        format.html { redirect_to meal_path(@meal.external_id), notice: "Review added successfully!" }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("review_form", partial: "meals/review_form", locals: {meal: @meal, review: @review}),
            flash_turbo_stream(type: :alert, messages: @review.errors.full_messages)
          ]
        end
        format.html { redirect_to meal_path(@meal.external_id), alert: @review.errors.full_messages.join(", ") }
      end
    end
  end

  def destroy
    @meal = @review.meal

    respond_to do |format|
      if @review.destroy
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("meal_rating", partial: "meals/meal_rating", locals: {meal: @meal}),
            turbo_stream.replace("review_form", partial: "meals/review_form", locals: {meal: @meal, review: @meal.meal_reviews.build}),
            turbo_stream.remove("review_#{@review.id}"),
            flash_turbo_stream(type: :success, message: "Review deleted successfully!")
          ]
        end
        format.html { redirect_to meal_path(@meal.external_id), notice: "Review deleted successfully!" }
      else
        format.turbo_stream do
          render turbo_stream: flash_turbo_stream(type: :alert, message: "Failed to delete review")
        end
        format.html { redirect_to meal_path(@meal.external_id), alert: "Failed to delete review" }
      end
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
end
