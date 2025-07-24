class PersonalReviewComponent < ReviewComponent
  def initialize(review:)
    @review = review
    @meal = review.meal
  end

  private

  attr_reader :review, :meal
end
