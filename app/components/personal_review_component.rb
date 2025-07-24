class PersonalReviewComponent < ReviewComponent
  def initialize(review:)
    @review = review
    @meal = review.meal
  end
end
